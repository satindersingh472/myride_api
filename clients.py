import json
from uuid import uuid4 
from flask import make_response,request
from dbhelpers import conn_exe_close
from apihelpers import verify_endpoints_info,upload_picture,bring_picture,send_email

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


# it will patch the image only expecting a key that is sent as a argument in a form data
def client_patch_image(key):
    # will use upload picture function and send the key with that to check the name of argument
    # it will further check the name of the file and turn it into hex for security
    image_name = upload_picture(key)
    if(image_name):
        # if everything goes fine then image name is true and have some value then none
        results = conn_exe_close('call client_patch_image(?,?)',[image_name,request.headers['token']])
        # if results has a list and first object row_count is 1 then this statement will be true
        if(type(results) == list and results[0]['row_count'] == 1):
            return make_response(json.dumps('image upload success',default=str),200)
        # if row count is 0 then this statement will be true
        elif(type(results) == list and results[0]['row_count'] == 0):
            return make_response(json.dumps('image upload failed',default=str),400)
        # if error then results will be string then this statement 
        elif(type(results) == str):
            return make_response(json.dumps(results,default=str),400)
        # if server error then this statement will be true
        else:
            return make_response(json.dumps(results,default=str),500)
    # if image name is none then this statement will be true
    else:
        return make_response(json.dumps('image not uploaded',default=str),400)

def client_patch_with_password():
    # will grab the new salt with uuid and hex
    salt = uuid4().hex
    # will send the password along with new salt and token
    results = conn_exe_close('call client_patch_with_password(?,?,?)',[request.json['password'],request.headers['token'],salt])
    # if password updated below result statement will be true and message will show up
    if(type(results) == list and results[0]['row_count'] == 1):
        return make_response(json.dumps('password update successfull',default=str),200)
        # if password does not get updated then below statement will show up
    elif(type(results) == list and results[0]['row_count'] == 0):
        return make_response(json.dumps('password update failed',default=str),400)
    else:
        # if any server error then this statament will be true
        return make_response(json.dumps(results,default=str),500)


def client_patch_all():
    # token inside a header is important for this endpoint and it will check if the token is sent as a header
    invalid_header = verify_endpoints_info(request.headers,['token'])
    if(invalid_header != None):
    # if token not sent then this message will show up
        return make_response(json.dumps(invalid_header,default=str),400)
    # if image is sent as file then this will execute a function based on condition
    # otherwise error
    invalid_image = verify_endpoints_info(request.files,['profile_image'])
    # if password is sent then function will get executed according to the condition
    invalid_password = verify_endpoints_info(request.json,['password'])
    # if password is sent and image is not sent then this statement will be true
    if(invalid_password == None and invalid_image != None):
        return client_patch_with_password()
    # if image is sent as a file and password is not sent then this statement will be true
    elif(invalid_image == None and invalid_password != None):
        return client_patch_image('profile_image')
    # if no password is sent and no image is sent then this statement will be true
    elif(invalid_image != None and invalid_password != None):
        return client_patch()