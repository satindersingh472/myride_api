import base64
import os
from flask import Flask, flash, request, redirect, url_for,current_app
from werkzeug.utils import secure_filename
from dbhelpers import conn_exe_close
from apihelpers import verify_endpoints_info, add_for_patch
from flask import Flask, request, make_response,send_from_directory
import json
import dbcreds


ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}

# current_app.secret_key = 'super secret key'



def download_file(name):
    return send_from_directory(current_app.config['UPLOAD_FOLDER'],name)


def post_picture():
    file = request.files.get('file')
    filename = secure_filename(file.filename)
    file.save(os.path.join(current_app.config['UPLOAD_FOLDER'], filename))
    return redirect(url_for('download_file',name=filename))

def get_picture():
    invalid_header = verify_endpoints_info(request.headers.get('token'))
    if(invalid_header != None):
        return make_response(json.dumps(invalid_header,default=str),400)
    results = conn_exe_close('call get_picture(?)',[request.headers['token']])
    with open(os.path.join(current_app.config['UPLOAD_FOLDER'],results[0]['profile_image'])) as my_image: 
        image = base64.b64encode(my_image.read())
    return image    






