
import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import dbcreds

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
        <p>
        Hi {name},<br>
        To use services at MyRide, please confirm that you have created an account at Myride by clicking yes. 
        </p>
        <a href="http://localhost:5000/api/user_verify?verified=1">
        <button style = "width:100px;background-color:green;font-size:2px;padding:5px;font-weight:bold;">Confirm</button>
        </a> 
        <br>
        <br>
        <a href="http://localhost:5000/api/user_verify?verified=0">
        <button style = "width:100px;background-color:red;font-size:2px;padding:5px;font-weight:bold;">Reject</button>
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
