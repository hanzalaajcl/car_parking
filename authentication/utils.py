from django.conf import settings
import random
# from django.contrib.auth.models import User
from .models import Users,Role
from django_rest_passwordreset.signals import reset_password_token_created,post_password_reset
# from django_rest_passwordreset.views import reset_password_request_token
from django.conf import settings
from email.message import EmailMessage
# from django.core.mail import EmailMessage
from datetime import timedelta
from django.utils import timezone

from smtplib import SMTP_SSL
# from django.dispatch import receiver
from django.dispatch import receiver
from django.contrib.sites.shortcuts import get_current_site
from django.utils.translation import gettext_lazy as _

from django.urls import reverse
from django.conf import settings
from django_rest_passwordreset.views import HTTP_USER_AGENT_HEADER,HTTP_IP_ADDRESS_HEADER,_unicode_ci_compare

from django_rest_passwordreset.models import ResetPasswordToken, clear_expired, get_password_reset_token_expiry_time, \
    get_password_reset_lookup_field
from rest_framework import exceptions
from email.mime.multipart import MIMEMultipart
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from parking.models import GlobalConfiguration
import random
import string

def generate_auth_key(length):
    characters = string.ascii_letters + string.digits
    auth_key = ''.join(random.choice(characters) for _ in range(length))
    return auth_key

def is_auth_key_unique(auth_key):
    return Users.objects.filter(auth_key=auth_key).first() is None




def get_email_host():
    email_host = "http://127.0.0.1:8000/"
    try:
        email_host = GlobalConfiguration.objects.get(name = "email_host").value
    except Exception as e:
        pass
    return email_host



@receiver(post_password_reset)
def for_verify_user(sender,user, *args, **kwargs):
    user.status = 'Verified'
    print("hello world")
    user.save()



@receiver(reset_password_token_created)
def password_reset_token_created(sender, instance, reset_password_token, *args, **kwargs):
    email_host = get_email_host()
    if email_host.endswith('/'):
        email_host = email_host[:-1]
    email_plaintext_message = "{}{}?token={}".format(email_host,reverse('reset-password-confirm'), reset_password_token.key)
    email_body = f"Hello {get_full_name(reset_password_token.user)},\n\nThank you for joing with us! We’re excited to let you know that your account has been created in the Parking App.\n\nPlease click on the following link to set your password and verify your account:\n\n{email_plaintext_message}\n\nIf you didn't request a password reset, please ignore this email.\n\nThank you"

    email_subject = "Thanks for Joining Parking App"
    # send_email_to_user(reset_password_token.user, email_subject, email_body)
    send_email_to_user(email_body, reset_password_token.user.email, email_subject)


def send_email_to_user(mail_content,receiver_address,subject):
    sender_address = 'CRMS@ajcl.net'
    sender_pass = 'Voz35072'
    #Setup the MIME
    message = MIMEMultipart()
    message['From'] = sender_address
    message['To'] = receiver_address
    message['Subject'] = subject
    #The body and the attachments for the mail
    message.attach(MIMEText(mail_content, 'html'))
    # count=1
    # for f in docPath:
    #     file_name=f.split("/")
    #     attach_file_name = f
    #     try:attach_file = open(attach_file_name, 'rb') # Open the file as binary mode
    #     except:
    #         try:
    #             temp=attach_file_name.split(".")
    #             attach_file = open(str(temp[0])+".docx", 'rb')
    #         except:pass
    #     payload = MIMEBase('application', 'octet-stream')
    #     payload.set_payload((attach_file).read())
    #     encoders.encode_base64(payload) #encode the attachment
    #     #add payload header with filename Content-Decomposition
    #     payload.add_header('Content-Disposition', 'attachment', filename=file_name[-1])
    #     message.attach(payload)
    #     count+=1
    #Create SMTP session for sending the mail
    session = smtplib.SMTP('smtp.office365.com', 587) #use gmail with port
    session.starttls() #enable security
    session.login(sender_address, sender_pass) #login with mail_id and password
    text = message.as_string()
    session.sendmail(sender_address, receiver_address, text)
    session.quit()
    print('Mail Sent')
        
        
def get_full_name(user_obj):
    fullname = ""
    if user_obj.first_name is not None:
        fullname += user_obj.first_name
    
        if user_obj.last_name is not None or user_obj.last_name != "" or user_obj.last_name != " ":
            fullname += " "+user_obj.last_name
    else:
        fullname += user_obj.email
    
    return fullname





def verify_email_on_user_registeration(self,request,email, user):
    password_reset_token_validation_time = get_password_reset_token_expiry_time()

    # datetime.now minus expiry hours
    now_minus_expiry_time = timezone.now() - timedelta(hours=password_reset_token_validation_time)

    # delete all tokens where created_at < now - 24 hours
    clear_expired(now_minus_expiry_time)

    # find a user by email address (case insensitive search)
    users = Users.objects.filter(**{'{}__iexact'.format(get_password_reset_lookup_field()): email})

    active_user_found = False

    # iterate over all users and check if there is any user that is active
    # also check whether the password can be changed (is useable), as there could be users that are not allowed
    # to change their password (e.g., LDAP user)
    for user in users:
        if user.eligible_for_reset():
            active_user_found = True
            break

    # No active user found, raise a validation error
    # but not if DJANGO_REST_PASSWORDRESET_NO_INFORMATION_LEAKAGE == True
    if not active_user_found and not getattr(settings, 'DJANGO_REST_PASSWORDRESET_NO_INFORMATION_LEAKAGE', False):
        raise exceptions.ValidationError({
            'email': [_(
                "We couldn't find an account associated with that email. Please try a different e-mail address.")],
        })

    # last but not least: iterate over all users that are active and can change their password
    # and create a Reset Password Token and send a signal with the created token
    for user in users:
        if user.eligible_for_reset() and \
                _unicode_ci_compare(email, getattr(user, get_password_reset_lookup_field())):
            # define the token as none for now
            token = None

            # check if the user already has a token
            if user.password_reset_tokens.all().count() > 0:
                # yes, already has a token, re-use this token
                token = user.password_reset_tokens.all()[0]
            else:
                # no token exists, generate a new token
                token = ResetPasswordToken.objects.create(
                    user=user,
                    user_agent=request.META.get(HTTP_USER_AGENT_HEADER, ''),
                    ip_address=request.META.get(HTTP_IP_ADDRESS_HEADER, ''),
                )
            # send a signal that the password token was created
            # let whoever receives this signal handle sending the email for the password reset
            reset_password_token_created.send(sender=self.__class__, instance=self, reset_password_token=token)