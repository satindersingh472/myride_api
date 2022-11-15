import json
from uuid import uuid4 
from flask import make_response,request,send_from_directory
from dbhelpers import conn_exe_close
from apihelpers import verify_endpoints_info,upload_picture,bring_picture,send_email,add_for_patch,remove_old_image


# will grab the information about the client id
def client_get():
    # it will check for client id as arguments
    invalid = verify_endpoints_info(request.args,['client_id'])
    # if not sent then error will show up
    if(invalid!= None):
        return make_response(json.dumps(invalid,default=str),400)
    # will call the stored procedure with token and id as a parameters
    results = conn_exe_close('call client_get(?)',[request.args['client_id']])
    # response will have all the info about client matching id and token
    if(type(results) == list and len(results) == 1):
        return make_response(json.dumps(results[0],default=str),200)
    # if not then error will show up
    elif(type(results) == list and len(results) != 1):
        return make_response(json.dumps('error getting user details',default=str),400)
    elif(type(results) != list ):
        # if list is not a response then error with code 400 show up
        return make_response(json.dumps(results,default=str),400)
    else:
        # if server error then 500 error code will show up
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
        # will show an error if duplicate email is being entered
    elif(type(results) == str and results.startswith('Duplicate entry')):
        return make_response(json.dumps('User already exists with same email',default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)

def client_delete():
    # will check if client sent token as a header
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        # if not then error 
        return make_response(json.dumps(invalid_headers,default=str),400)
    #   will check if user sent password or not
    invalid = verify_endpoints_info(request.json,['password'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
          # will send request to the stored procedure with password and token
    results = conn_exe_close('call client_delete(?,?)',[request.json['password'],request.headers['token']])
    if(type(results) == list and results[0]['row_count'] == 1):
        # on success row count will be one
        return make_response(json.dumps('client delete successfull',default=str),200)
    elif(type(results) == list and results[0]['row_count'] == 0):
        # on failure row count will be 0
        return make_response(json.dumps('client delete failed',default=str),400)
    elif(type(results) != list):
        # if mistake made then no list onlt string will be there as a response
        return make_response(json.dumps(results,default=str),400)
    else:
        # if any other error the server has made that error and 500 code as a response will be back
        return make_response(json.dumps(results,default=str),500)


# will get the profile image with a given token
def client_get_image():
    # check if id is sent as args
    invalid = verify_endpoints_info(request.args,['client_id'])
    if(invalid != None):
        # will return the function if token is not sent
        return make_response(json.dumps(invalid,default=str),400)
        # will make a request to get the image name from db
    results = conn_exe_close('call client_get_image(?)',[request.args['client_id']])
    # if name was there then response is ok and use the name to grab image from server
    if(type(results) == list and results[0]['profile_image'] != None):
        # results[0]['profile_image'] = bring_picture(results[0]['profile_image'])
        return send_from_directory('files/profile_images',results[0]['profile_image'])
        # return make_response(json.dumps(results,default=str),200)
        # else errors will show up
    elif(len(results) == 0 or results[0]['profile_image'] == None ):
        return make_response(json.dumps(results,default=str),400)
    elif(type(results) == str):
        return make_response(json.dumps(results,default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)





# it will patch the image only expecting a key that is sent as a argument in a form data
def client_patch_image():
     # token inside a header is important for this endpoint and it will check if the token is sent as a header
    invalid_header = verify_endpoints_info(request.headers,['token'])
    if(invalid_header != None):
        return make_response(json.dumps(invalid_header,default=str),400)
    invalid = verify_endpoints_info(request.files,['profile_image'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    # will bring the name of old image just to delete it from the server
    old_image = conn_exe_close('call client_old_image(?)',[request.headers['token']])
    old_image = old_image[0]['profile_image']
    # will use upload picture function and send the key with that to check the name of argument
    # it will further check the name of the file and turn it into hex for security
    image_name = upload_picture('profile_image')
    if(image_name):
        # if everything goes fine then image name is true and have some value then none
        results = conn_exe_close('call client_patch_image(?,?)',[image_name,request.headers['token']])
        # if results has a list and first object row_count is 1 then this statement will be true
        if(type(results) == list and results[0]['row_count'] == 1):
            # will get image so that to display the user instant changes
            # remove old picture will delete the old image from server we got from database 
            image = bring_picture(image_name)
            if(old_image != '' and old_image != None):
                remove_old_image(old_image)
            return make_response(json.dumps(image,default=str),200)
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


# will update everyinfo except id,password,salt,image and verified in the client table
# with the help of a token
def client_patch():
    # to achieve this original information will be needed from the table
    # so that if something is not sent then original information will be used to send along the request
    results = conn_exe_close('call client_get_with_token(?)',[request.headers['token']])
    # will check if the original data is sent by the database is a list or not
    # if not list then there is an error
    if(type(results) != list):
        return make_response(json.dumps(results,default=str),400)
    # also another layer for error is added 
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps('something went wrong, login again can solve the problem',default=str),400)
    # these are the required arguments we need to have for the stored procedure to update the data for client
    required_args = ['first_name','last_name','email','address','city','phone_number','bio','dob']
    # add to patch will just check if something is not sent then it will stick the older data from db
    # if something is sent from the user then it will overwrite the data from the original data sent and 
    # it will still send the original data even if it is overwritten in full with new values sent by user to change
    results = add_for_patch(request.json,required_args,results[0])
    # now from data coming from add_to_patch we will send the arguments along with token to the database to make a change and
    # expect number of rows to get changed
    results = conn_exe_close('call client_patch(?,?,?,?,?,?,?,?,?)',
    [results['first_name'],results['last_name'],results['email'],results['address'],results['city'],results['phone_number'],
    results['bio'],results['dob'],request.headers['token']])
    # if row count is 1 then change has happened and reponse is 200
    if(type(results) == list and results[0]['row_count'] == 1):
        return make_response(json.dumps('profile update successfull',default=str),200)
    # if row count is 0 then nothing has changed and error is 400
    elif(type(results) == list and results[0]['row_count'] == 0):
        return make_response(json.dumps('profile update failed',default=str),400)
    elif(type(results) != list or len(results) == 0):
    # if error happend in sending data then the following statment is true
        return make_response(json.dumps(results,default=str),400)
        # if server error then 500 is shown
    else:
        return make_response(json.dumps(results,default=str),500)


def client_patch_all():
    # token inside a header is important for this endpoint and it will check if the token is sent as a header
    invalid_header = verify_endpoints_info(request.headers,['token'])
    if(invalid_header != None):
    # if token not sent then this message will show up
        return make_response(json.dumps(invalid_header,default=str),400)
    if(request.json.get('password') != None):
        return client_patch_with_password()
    # if password is not sent then this statement will be true
    else:
        return client_patch()
 