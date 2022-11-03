from dbhelpers import conn_exe_close
from apihelpers import verify_endpoints_info, add_for_patch,upload_picture
from flask import Flask, request, make_response
import json,os,base64
import dbcreds
from rough_work import post_picture

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'files/profile_images'


@app.post('/api/user')
def use_upload_picture():
    return upload_picture()


def show_image():
    with open(os.path.join(app.config['UPLOAD_FOLDER'],'foodie_order.png'),'rb') as my_image: 
        image = base64.b64encode(my_image.read())
    return image   

show_image()

if(dbcreds.production_mode == True):
    import bjoern #type: ignore
    bjoern.run(app,'0.0.0.0',5300)
    print('Running in PRODUCTION MODE')
else:
    from flask_cors import CORS
    CORS(app)
    print('Running in TESTING MODE')
    app.run(debug=True)


