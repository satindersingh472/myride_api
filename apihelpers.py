import os,base64
from flask import request,flash
from uuid import uuid4
import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import dbcreds


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
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
def allowed_file(filename):
    return '.' in filename and \
        filename.rsplit('.',1)[1].lower() in ALLOWED_EXTENSIONS

# this function will upload the image file into server upon checking the file type from allowed extensions
def upload_picture(key):
    # if no file is sent then no file part is shown 
    if key not in request.files:
        flash('No file part')
        return None
    file = request.files.get(key)
    # if filename is empty then no selected file is shown
    if file.filename == '':
        flash('No selected file')
        return None
        # if file is sent and file is not empty then check for file type
        # will return true if file type is in allowed extension
    if file and allowed_file(file.filename):
        filename = uuid4().hex + '.' + file.filename.rsplit('.',1)[1].lower()
        file.save(os.path.join(dbcreds.path_to_images,filename))
        return filename

# will bring back the file from the server as a string and read it as a binary 
# but i am using send from directory
def bring_picture(image_name):
    with open(os.path.join(dbcreds.path_to_images,image_name),'rb') as my_image: 
        image = base64.b64encode(my_image.read())
    return image.decode('utf-8')

def remove_old_image(image_name):
    os.remove(os.path.join(dbcreds.path_to_images,image_name))
    



def send_email(email,name,token):
    port = 465  # For SSL
    smtp_server = "smtp.gmail.com"
    sender_email = "developersatinder@gmail.com"  # Enter your address
    receiver_email = f"{email}"  # Enter receiver address
    password = dbcreds.gmail_password

    message = MIMEMultipart("alternative")
    message["Subject"] = "multipart test"
    message["From"] = sender_email
    message["To"] = receiver_email

    # Create the plain-text and HTML version of your message
    html = f"""\
    <html>
    <body>
        <p>Hi {name},</p>
        <p>  To use services at MyRide, please confirm that you have created an account at Myride. 
        </p>
        <a href="https://myride.ml/api/client_verify?verified=1&token={token}">
        <button style = "width:100px;background-color:green;font-size:2px;padding:5px;font-weight:bold;">Confirm</button>
        </a>        
    </body>
    </html>
    """

    # Turn these into plain/html MIMEText objects
    part1 = MIMEText(html, "html")

    # Add HTML/plain-text parts to MIMEMultipart message
    # The email client will try to render the last part first
    message.attach(part1)

    context = ssl.create_default_context()
    with smtplib.SMTP_SSL(smtp_server, port, context=context) as server:
        server.login(sender_email, password)
        server.sendmail(sender_email, receiver_email, message.as_string())
