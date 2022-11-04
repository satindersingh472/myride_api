import json
from uuid import uuid4 
from flask import make_response,request
from dbhelpers import conn_exe_close
from apihelpers import verify_endpoints_info,upload_picture,bring_picture,send_email

# will work when client confirm from an email and this function is tied with /api/client_verified
# it is accepting verified argument and token argument from email
def client_verify():
    # will check if user has sent a valid token and verified argument
    invalid_argument = verify_endpoints_info(request.args,['verified','token'])
    if(invalid_argument != None):
        return make_response(json.dumps(invalid_argument,default=str),400)
        # if everything is fine then store procedure will get called 
    results = conn_exe_close('call client_verify(?,?)',[request.args['verified'],request.args['token']])
    # if it chnages anything in the database row count will be 1 other wise 0
    if(type(results) == list and results[0]['row_count'] == 1):
        return make_response(json.dumps('your account is verified successfully',default=str),200)
    elif(type(results) == list and results[0]['row_count'] == 0):
        # if row count is 0 then the foll statement will be true
        return make_response(json.dumps('account already verified',default=str),400)
    elif(type(results) == str):
        return make_response(json.dumps(results,default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)



# client post will add a client to the database and at first it will just add first_name,last_name
# email and password and token and salt for security and login 
def client_post():
    # will check for various data if it is sent or not
    invalid = verify_endpoints_info(request.json,
    ['first_name','last_name','email','password'])
    # if not then error will pop up
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
        # will generate a token and salt to send along with a request
    token = uuid4().hex
    salt = uuid4().hex
    # will generate a full name by adding two strings togather 
    name = request.json['first_name'] + ' ' + request.json['last_name']
    # send the request to client_post stored procedure
    results = conn_exe_close('call client_post(?,?,?,?,?,?)',
    [request.json['first_name'],request.json['last_name'],request.json['email'],request.json['password'],token,salt])
    if(type(results) == list and len(results) == 1):
        # if client gets added to the db then row count will help us know that
        # after response the email will be sent to the clients give email address by developersatinder@gmail.com
        # for verifying the client
        send_email(request.json['email'],name,token)
        return make_response(json.dumps(results[0],default=str),200)
    elif(type(results) == list and len(results) != 1):
        return make_response(json.dumps(results,default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)