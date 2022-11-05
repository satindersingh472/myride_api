import json
from flask import request,make_response
from apihelpers import verify_endpoints_info
from dbhelpers import conn_exe_close


def ride_post():
    invalid_headers = verify_endpoints_info(request.json,['token'])
    if(invalid_headers != None):
        return make_response(json.dumps(invalid_headers,default=str),400)
    invalid = verify_endpoints_info(request.json,['from_city','to_city','travel_data','leave_time'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    results = conn_exe_close('call ride_post(?,?,?,?,?)',
    [request.json['from_city'],request.json['to_city'],request.json['travel_date'],request.json['leave_time']])
    if(type(results) == list and len(results) == 1):
        return make_response(json.dumps(results[0],default=str),200)
    elif(type(results) == list and len(results) != 1):
        return make_response(json.dumps('ride post failed',default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)