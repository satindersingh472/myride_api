import json
from uuid import uuid4 
from flask import make_response,request
from dbhelpers import conn_exe_close
from apihelpers import verify_endpoints_info,upload_picture,bring_picture,send_email


def client_patch_image():
    invalid_header = verify_endpoints_info(request.headers,['token'])
    if(invalid_header != None):
        return make_response(json.dumps(invalid_header,default=str),400)
    image_name = upload_picture()
    if(image_name):
        results = conn_exe_close('call client_patch_image(?,?)',[image_name,request.headers['token']])
        if(type(results) == list and results[0]['row_count'] == 1):
            return make_response(json.dumps('image upload success',default=str),200)
        elif(type(results) == list and results[0]['row_count'] == 0):
            return make_response(json.dumps('image upload failed',default=str),400)
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