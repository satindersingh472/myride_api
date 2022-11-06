from flask import Flask
import dbcreds
from clients import client_get,client_post,client_patch_all,client_patch_image,client_delete
from apihelpers import upload_picture
from client_verification import client_verify,client_verified
from client_login import client_login,client_logout
from ride import ride_post,ride_patch,ride_get,ride_delete,rides_get_all

app = Flask(__name__)
# -----------------------------------------------
# will login the client 
@app.post('/api/client_login')
def use_client_login():
    return client_login()

# will logout the client
@app.delete('/api/client_login')
def use_client_logout():
    return client_logout()

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

# will get the information about the client
@app.get('/api/client')
def use_client_get():
    return client_get()

# it will post a new client credentials
@app.post('/api/client')
def use_client_post():
    return client_post()

# will edit the client info for example password,name.etc
@app.patch('/api/client')
def use_client_patch_all():
    return client_patch_all()

# will delete the client from the database
@app.delete('/api/client')
def use_client_delete():
    return client_delete()

# -------------------------------------------------------
# will patch the client image
@app.patch('/api/client_image')
def use_client_patch_image():
    return client_patch_image()
# -------------------------------------------------------

@app.get('/api/rides')
def use_rides_get_all():
    return rides_get_all()


# --------------------------------------------------------
# post a new ride
@app.post('/api/ride')
def use_ride_post():
    return ride_post()

# edit the information about the ride
@app.patch('/api/ride')
def use_ride_patch():
    return ride_patch()

# get the inform
@app.get('/api/ride')
def use_ride_get():
    return ride_get()

@app.delete('/api/ride')
def use_ride_delete():
    return ride_delete()

# -----------------------------------------------------------
if(dbcreds.production_mode == True):
    import bjoern #type: ignore
    bjoern.run(app,'0.0.0.0',5300)
    print('Running in PRODUCTION MODE')
else:
    from flask_cors import CORS
    CORS(app)
    print('Running in TESTING MODE')
    app.run(debug=True)


