import json
from flask import request,make_response
from apihelpers import verify_endpoints_info,add_for_patch
from dbhelpers import conn_exe_close

def booking_post():
    invalid_headers = verify_endpoints_info(request.headers,['token'])
    if(invalid_headers != None):
        return make_response(json.dumps(invalid_headers,default=str),400)
    invalid = verify_endpoints_info(request.json,['ride_id'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    results = conn_exe_close('call booking_post(?,?)',[request.json['ride_id'],request.headers['token']])
    if(type(results) == list and len(results) == 1):
        return make_response(json.dumps(results[0],default=str),200)
    elif(type(results) == list and len(results) == 0):
        return make_response(json.dumps('booking post failed',default=str),400)
    elif(type(results) == str):
        return make_response(json.dumps(results,default=str),400)
    else:
        return make_response(json.dumps(results,default=str),500)


