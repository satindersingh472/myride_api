import json
from flask import request,make_response
from apihelpers import verify_endpoints_info,add_for_patch
from dbhelpers import conn_exe_close

# it will get the information regarding the booking for the passenger
# will require a valid token and client id as a passenger id
def booking_passenger_get():
    # check for header if token is sent or not
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        # if not then foll error will show up
        return make_response(json.dumps(invalid_headers,default=str),400)
    # check if client id is sent as params or not
    invalid = verify_endpoints_info(request.args,['client_id'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    # make a req to db to get the booking for client id and token given
    results = conn_exe_close('call booking_passenger_get(?,?)',[request.args['client_id'],request.headers['token']])
    # will check len and type of results and send the response accordingly
    if(type(results) == list and len(results) != 0 ):
        return make_response(json.dumps(results,default=str),200)
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps('no booking available',default=str),400)
    elif(type(results) == str):
        return make_response(json.dumps(results,default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)




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


# will delete the booking from passenger side with valid token and booking id
def booking_passenger_delete():
    # will check the header if token argument is sent or not
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        # if token argument not sent then error will show up
        return make_response(json.dumps(invalid_headers,default=str),400)
    # will check if booking id argument as a data is sent or not if not sent then error will show up
    invalid = verify_endpoints_info(request.json,['booking_id'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
        # will make a request to delete the booking sending booking id and token
    results = conn_exe_close('call booking_passenger_delete(?,?)',[request.json['booking_id'],request.headers['token']])
    # expect results as a list and at index 0 the row count key should have 1 
    # other wise if 0 then no booking is deleted 
    # if booking already deleted and user try to delete it once one then this error will be shown
    if(type(results) == list and results[0]['row_count'] ==1 ):
        return make_response(json.dumps('booking delete successfull',default=str),200)
    elif(type(results) == list and results[0]['row_count'] == 0):
        # if nothing got deleted
        return make_response(json.dumps('booking delete failed',default=str),400)
    elif(type(results) != list):
        # if error in data sent by user 
        return make_response(json.dumps(results,default=str),400)
    else:
        # if server error
        return make_response(json.dumps(results,default=str),500)