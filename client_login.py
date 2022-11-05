import json
from flask import request,make_response
from apihelpers import verify_endpoints_info
from dbhelpers import conn_exe_close
from uuid import uuid4

def client_login():
    invalid = verify_endpoints_info(request.json,['email','password'])
    if(invalid != None):
        return make_response(json.dumps(invalid,default=str),400)
    token = uuid4().hex
    results = conn_exe_close('call client_login(?,?,?)',[request.json['email'],request.json['password'],token])
    if(type(results) == list and len(results) == 1):
        return make_response(json.dumps(results[0],default=str),200)