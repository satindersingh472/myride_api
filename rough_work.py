
import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import dbcreds

def send_email(email,name):
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
        hi {name},
        please confirm that you have created an account at Myride by clicking yes.
        <a href="http://www.myride.ml/api/user_verify/">
        <button style = font-size:2px;background:green;padding:5px;font-weight:bold;">YES</button>
        </a> 
        </p>
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


send_email('satindersingh472@gmail.com','satinder singh')