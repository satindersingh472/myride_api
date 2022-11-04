from flask import Flask
import dbcreds
from clients import client_post
from apihelpers import upload_picture
from client_verification import client_verify

app = Flask(__name__)

#--------------------------------------------------
 
@app.get('/api/client_verify')
def use_client_verify():
    return client_verify()

# -------------------------------------------------
@app.post('/api/client')
def use_client_post():
    return client_post()



if(dbcreds.production_mode == True):
    import bjoern #type: ignore
    bjoern.run(app,'0.0.0.0',5300)
    print('Running in PRODUCTION MODE')
else:
    from flask_cors import CORS
    CORS(app)
    print('Running in TESTING MODE')
    app.run(debug=True)


