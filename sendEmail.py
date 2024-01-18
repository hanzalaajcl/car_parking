import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import os

#The mail addresses and password
def sendMail(mail_content,receiver_address,subject,docPath):
    sender_address = 'CRMS@ajcl.net'
    sender_pass = 'Voz35072'
    #Setup the MIME
    message = MIMEMultipart()
    message['From'] = sender_address
    message['To'] = receiver_address
    message['Subject'] = subject
    #The body and the attachments for the mail
    message.attach(MIMEText(mail_content, 'html'))
    count=1
    for f in docPath:
        file_name=f.split("/")
        attach_file_name = f
        try:attach_file = open(attach_file_name, 'rb') # Open the file as binary mode
        except:
            try:
                temp=attach_file_name.split(".")
                attach_file = open(str(temp[0])+".docx", 'rb')
            except:pass
        payload = MIMEBase('application', 'octet-stream')
        payload.set_payload((attach_file).read())
        encoders.encode_base64(payload) #encode the attachment
        #add payload header with filename Content-Decomposition
        payload.add_header('Content-Disposition', 'attachment', filename=file_name[-1])
        message.attach(payload)
        count+=1
    #Create SMTP session for sending the mail
    session = smtplib.SMTP('smtp.office365.com', 587) #use gmail with port
    session.starttls() #enable security
    session.login(sender_address, sender_pass) #login with mail_id and password
    text = message.as_string()
    session.sendmail(sender_address, receiver_address, text)
    session.quit()
    print('Mail Sent')
