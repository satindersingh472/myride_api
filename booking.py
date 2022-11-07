import json
from flask import request,make_response
from apihelpers import verify_endpoints_info,add_for_patch
from dbhelpers import conn_exe_close


# will post a new booking for a passenger given valid token and valid ride_id
def booking_post():
    # will check for header if token is sent
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    # if not sent error will show up
    if(invalid_headers != None):
        return make_response(json.dumps(invalid_headers,default=str),400)
    invalid = verify_endpoints_info(request.json,['ride_id'])
    # if ride id is not sent then error will show up
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    # will make request to the stored prodecure to add booking to the database
    results = conn_exe_close('call booking_post(?,?)',[request.json['ride_id'],request.headers['token']])
    # if results is list and len is one then response is 200
    if(type(results) == list and len(results) == 1):
        return make_response(json.dumps(results[0],default=str),200)
    # if results list and len 0 then following will be true
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps('booking post failed',default=str),400)
    # this will be true if results is string
    elif(type(results) == str):
        return make_response(json.dumps(results,default=str),400)
    else:
        # if server errror then this will be true
        return make_response(json.dumps(results,default=str),500)


