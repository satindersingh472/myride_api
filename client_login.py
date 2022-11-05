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