import json
from uuid import uuid4
from flask import request,make_response,redirect
from apihelpers import verify_endpoints_info
from dbhelpers import conn_exe_close


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
    # upon success the user will be redirected to the following address
    if(type(results) == list and results[0]['row_count'] == 1):
        return redirect('http://myride.ml/#/client_verified')
        # return make_response(json.dumps('your account is verified successfully',default=str),200)
    elif(type(results) == list and results[0]['row_count'] == 0):
        return redirect('http://myride.ml/#/client_verified')
        # if row count is 0 then the foll statement will be true
        # return make_response(json.dumps('account already verified',default=str),400)
    elif(type(results) == str):
        return make_response(json.dumps(results,default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)

# 
# this function will check if client has verified status or not
# if verified then response will be object with verified key value 1 and 
# not verified will be with value 0
def client_verified():
    # will check if user sent a header or not
    invalid_header = verify_endpoints_info(request.headers,['token'])
    if(invalid_header != None):
        # if header not sent then error will show up
        return make_response(json.dumps(invalid_header,default=str),400)
    # call the stored procedure and save the response inside results
    results = conn_exe_close('call client_verified(?)',[request.headers['token']])
    # if client is verified then response is a list of one object with verified key of value 1
    # if not verified then 0 
    if(type(results) == list and len(results) == 1):
        return make_response(json.dumps(results[0],default=str),200)
    elif(type(results) == list and len(results) != 1):
        return make_response(json.dumps('invalid user',default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)