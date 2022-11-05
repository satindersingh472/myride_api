import json
from flask import request,make_response
from apihelpers import verify_endpoints_info
from dbhelpers import conn_exe_close
from uuid import uuid4

# will login the client with email and password and generating token with uuid4
def client_login():
    # will check if email and password is sent or not
    invalid = verify_endpoints_info(request.json,['email','password'])
    if(invalid != None):
        # if not then errror will show up
        return make_response(json.dumps(invalid,default=str),400)
    # generate a random token
    token = uuid4().hex
    # will call the stored procedure and get the response from database
    results = conn_exe_close('call client_login(?,?,?)',[request.json['email'],request.json['password'],token])
    # if response is list and len is one then it means the use is logged in and we got the token and id back
    if(type(results) == list and len(results) == 1):
        return make_response(json.dumps(results[0],default=str),200)
    # if results is a list of 0 length i.e. error or invalid credentials from client
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps('invalid email or password',default=str),400)
        # else server error can send 500 error code as a response with an error
    else:
        return make_response(json.dumps(results,default=str),500)

# will logout the client from the client sessions
def client_logout():
    # if token is not sent as a header then error will show up
    invalid_header = verify_endpoints_info(request.headers,['token'])
    if(invalid_header != None):
        return make_response(json.dumps(invalid_header,default=str),400)
    # after a token is sent then stored procedured will be called and we expect a row count with 1
    results = conn_exe_close('call client_logout(?)',[request.headers['token']])
    if(type(results) == list and results[0]['row_count'] == 1):
        return make_response(json.dumps('client logout successfull',default=str),200)
    # this statement will be true if user sends invalid token 
    elif(type(results) == list and results[0]['row_count'] == 0):
        return make_response(json.dumps('client logout failed',default=str),400)
    elif(type(results) != list):
        # if any other error occurs this statemtn will be true
        return make_response(json.dumps(results,default=str),400)
                # if server error this statement will be true
    else:
        return make_response(json.dumps(results,default=str),500)