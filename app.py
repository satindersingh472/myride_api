from flask import Flask
import dbcreds
from clients import client_get,client_post,client_patch_all
from apihelpers import upload_picture
from client_verification import client_verify,client_verified

app = Flask(__name__)

#--------------------------------------------------
#  it will help the request from email to verify the client 
@app.get('/api/client_verify')
def use_client_verify():
    return client_verify()

# it will send back the response about the verification status of a client
@app.get('/api/client_verified')
def use_client_verified():
    return client_verified()

# -------------------------------------------------

@app.get('/api/client')
def use_client_get():
    return client_get()

# it will post a new client credentials
@app.post('/api/client')
def use_client_post():
    return client_post()

@app.patch('/api/client')
def use_client_patch_all():
    return client_patch_all()



if(dbcreds.production_mode == True):
    import bjoern #type: ignore
    bjoern.run(app,'0.0.0.0',5300)
    print('Running in PRODUCTION MODE')
else:
    from flask_cors import CORS
    CORS(app)
    print('Running in TESTING MODE')
    app.run(debug=True)


