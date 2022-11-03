import json
from flask import make_response,request
from apihelpers import upload_picture,bring_picture


def picture_post():
    results = upload_picture()
    return bring_picture(results)