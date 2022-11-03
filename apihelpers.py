import os
from flask import request,flash,redirect
from werkzeug.utils import secure_filename


# the following function will over write the new data that has passed by user with the original data in the request
def add_for_patch(sent_data,required_args,original_data):
    for data in required_args:
        if(sent_data.get(data) != None):
            original_data[data] = sent_data[data]
    return original_data
    

# will verifiy end points arguments for presence
# if necessary arguments not sent then remind the user to send
def verify_endpoints_info(sent_data,required_args):
    for data in required_args:
        if(sent_data.get(data) == None):
            return f'The {data} argument is required'


# will help store the files inside the server
# the files will not be publically available
ALLOWED_EXTENSIONS = {'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'}
def allowed_file(filename):
    return '.' in filename and \
        filename.rsplit('.',1)[1].lower() in ALLOWED_EXTENSIONS

def upload_picture():
    if 'file' not in request.files:
        flash('No file part')
        return redirect(request.url)
    file = request.files.get('file')
    if file.filename == '':
        flash('No selected file')
        return redirect(request.url)
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join('files/profile_images',filename))
        return filename