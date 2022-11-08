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

# def will confirm the booking with just checking is confirmed is true 
def booking_rider_patch_confirm():
    # if is_confirmed in true then it will make the request to the stored procedure
    if(request.json['is_confirmed'] in ['true','True',0]):
        results = conn_exe_close('call booking_rider_patch_confirm(?,?)',[request.json['booking_id'],request.headers['token']])
        # if response is list and results[0] row count is 1 
        # i.e. then booking is confirmed
        if(type(results) == list and results[0]['row_count'] == 1):
            return make_response(json.dumps('booking confirm successful',default=str),200)
        # if results[0] row_count is 0 booking confirm failed
        elif(type(results) == list and results[0]['row_count'] == 0):
            return make_response(json.dumps('booking confirm failed',default=str),400)
        elif(type(results) == str):
            # results type string cause of an error
            return make_response(json.dumps(results,default=str),400)
        else:
            # server error will be shown with 500 error code
            return make_response(json.dumps(results,default=str),500)
    else:
        # if is_confirmed is not in true then it is not allowed
        return make_response(json.dumps('booking can be confirmed only, sending false for is_confirmed not allowed',default=str),400)


# this will check for is_confirmed and is_completed and divert the function towards
# function will executed according to the condition satisfied
def booking_rider_patch_all():
    # will check if token is sent as header
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        # if not then error is sent
        return make_response(json.dumps(invalid_headers,default=str),400)
    # will check if booking id is sent as json or not
    invalid = verify_endpoints_info(request.json,['booking_id'])
    if(invalid != None):
        # if not then error is sent
        return make_response(json.dumps(invalid,default=str),400)
    # is confirmed and is completed are declared just to make checking the condition easier
    is_confirmed = request.json.get('is_confirmed')
    is_completed = request.json.get('is_completed')
    # if is confirmed is sent then will execute the below statement
    if(is_confirmed != None and is_completed == None):
        return booking_rider_patch_confirm()
    