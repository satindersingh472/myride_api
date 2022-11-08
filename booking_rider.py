import json
from flask import request,make_response
from apihelpers import verify_endpoints_info,add_for_patch
from dbhelpers import conn_exe_close 

# will get the booking on rider side with a valid ride id and token
def booking_rider_get():
    # check for token if sent or not will show error if not sent
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        return make_response(json.dumps(invalid_headers,default=str),400)
    # will check if ride id is sent or not 
    invalid = verify_endpoints_info(request.args,['ride_id'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    # if token and id are sent then make a request to grab the details about the ride 
    results = conn_exe_close('call booking_rider_get(?,?)',[request.args['ride_id'],request.headers['token']])
    if(type(results) == list and len(results) != 0):
        # if there is any booking then it will true 
        return make_response(json.dumps(results,default=str),200)
    elif(type(results) == list and len(results) == 0):
        # if no booking then this will be true
        return make_response(json.dumps('no bookings available',default=str),400)
    elif(type(results) != list):
        # if error then this statement will be true
        return make_response(json.dumps(results,default=str),400)
    else:
        # in case of other error this will be true
        return make_response(json.dumps(results,default=str),500)


def booking_rider_patch_confirm():
    if(request.json['is_confirmed'] in ['true','True',0]):
        results = conn_exe_close('call booking_rider_patch_confirm(?,?)',[request.json['booking_id'],request.headers['token']])
        if(type(results) == list and results[0]['row_count'] == 1):
            return make_response(json.dumps('booking confirm successful',default=str),200)
        elif(type(results) == list and results[0]['row_count'] == 0):
            return make_response(json.dumps('booking confirm failed',default=str),400)
        elif(type(results) == str):
            return make_response(json.dumps(results,default=str),400)
        else:
            return make_response(json.dumps(results,default=str),500)
    else:
        return make_response(json.dumps('booking can be confirmed only, sending false for is_confirmed not allowed',default=str),400)



def booking_rider_patch_all():
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        return make_response(json.dumps(invalid_headers,default=str),400)
    invalid = verify_endpoints_info(request.json,['booking_id'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    is_confirmed = request.json.get('is_confirmed')
    is_completed = request.json.get('is_completed')
    if(is_confirmed != None and is_completed == None):
        return booking_rider_patch_confirm()
    