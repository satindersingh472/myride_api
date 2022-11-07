import json
from flask import request,make_response
from apihelpers import verify_endpoints_info,add_for_patch
from dbhelpers import conn_exe_close

def booking_post():
    

