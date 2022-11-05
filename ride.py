import json
from flask import request,make_response
from apihelpers import verify_endpoints_info,add_for_patch
from dbhelpers import conn_exe_close


def ride_patch():
    invalid_headers = verify_endpoints_info(request.headers,['ride_id','token'])
    if(invalid_headers != None):
        return make_response(json.dumps(invalid_headers,default=str),400)
    results = conn_exe_close('call ride_get_for_patch(?,?)',[request.headers['ride_id'],request.headers['token']])
    required_data = ['from_city','to_city','travel_date','leave_time']
    results = add_for_patch(request.json,required_data,results[0])
    results = conn_exe_close('call ride_patch(?,?,?,?,?,?)',
    [request.json['from_city'],request.json['to_city'],request.json['travel_date'],request.json['leave_time'],
    request.headers['ride_id'],request.headers['token']])
    if(type(results) == list and results[0]['row_count'] == 1):
        return make_response(json.dumps('ride update successfull',default=str),200)
    elif(type(results) == list and results[0]['row_count'] == 0):
        return make_response(json.dumps('ride update failed',default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)
    



def ride_post():
    # will check for token as a header is sent or not
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        return make_response(json.dumps(invalid_headers,default=str),400)
    # will check for required data is sent or not if not then it will ask for that
    invalid = verify_endpoints_info(request.json,['from_city','to_city','travel_date','leave_time'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    # after everythin sent it will call the stored procedure to post the ride 
    results = conn_exe_close('call ride_post(?,?,?,?,?)',
    [request.json['from_city'],request.json['to_city'],request.json['travel_date'],request.json['leave_time'],request.headers['token']])
    if(type(results) == list and results[0]['rides_posted_count'] == 1):
        # if ride posted successfully then it will give back the number of rides posted and ride id
        return make_response(json.dumps(results[0],default=str),200)
        # if no ride posted then error will show up from the following statment
    elif(type(results) == list and results[0]['rides_posted_count'] == 0):
        return make_response(json.dumps('ride post failed',default=str),400)
    else:
        # server error will show up as error 500
        return make_response(json.dumps(results,default=str),500)