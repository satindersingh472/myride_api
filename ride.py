import json
from flask import request,make_response
from apihelpers import verify_endpoints_info
from dbhelpers import conn_exe_close


def ride_post():
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        return make_response(json.dumps(invalid_headers,default=str),400)
    invalid = verify_endpoints_info(request.json,['from_city','to_city','travel_date','leave_time'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    results = conn_exe_close('call ride_post(?,?,?,?,?)',
    [request.json['from_city'],request.json['to_city'],request.json['travel_date'],request.json['leave_time'],request.headers['token']])
    if(type(results) == list and results[0]['row_count'] == 1):
        return make_response(json.dumps(results[0],default=str),200)
    elif(type(results) == list and results[0]['row_count'] == 0):
        return make_response(json.dumps('ride post failed',default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)