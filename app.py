import os
from flask import Flask, flash, request, redirect, url_for
from werkzeug.utils import secure_filename
from dbhelpers import conn_exe_close
from apihelpers import verify_endpoints_info, add_for_patch
from flask import Flask, request, make_response,send_from_directory
import json
import dbcreds

app = Flask(__name__)
ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}
app.config['UPLOAD_FOLDER'] = 'images'
app.secret_key = 'super secret key'


@app.get('/api/user/<name>')
def download_file(name):
    return send_from_directory(app.config['UPLOAD_FOLDER'],name)


@app.post('/api/user')
def post_picture():
    file = request.files.get('file')
    filename = secure_filename(file.filename)
    file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    return redirect(url_for(send_from_directory(app.config['UPLOAD_FOLDER'],filename))) 




if(dbcreds.production_mode == True):
    import bjoern #type: ignore
    bjoern.run(app,'0.0.0.0',5300)
    print('Running in PRODUCTION MODE')
else:
    from flask_cors import CORS
    CORS(app)
    print('Running in TESTING MODE')
    app.run(debug=True)


