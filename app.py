from clients import picture_post
from flask import Flask
import dbcreds

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'files/profile_images'

@app.post('/api/user')
def use_picture_post():
    return picture_post()


if(dbcreds.production_mode == True):
    import bjoern #type: ignore
    bjoern.run(app,'0.0.0.0',5300)
    print('Running in PRODUCTION MODE')
else:
    from flask_cors import CORS
    CORS(app)
    print('Running in TESTING MODE')
    app.run(debug=True)


