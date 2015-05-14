from flask import Flask


class Config(object):
    """
        Configuration settings for final parsec website.
    """
    SECRET_KEY = 'my_secret_key'
    CSRF_ENABLED = True
    MC_KEY = 'mc_key'

    #Database Connection Strings
    SQLALCHEMY_DATABASE_URI = '{protocol}://{user}:{password}@{host}/{database}?charset=utf8'.format(
        protocol='mysql+pymysql',
        user='mysql_username',
        password='mysql_password',
        host='mysql_hostname',
        database='mysql_schema'
    )

    # Flask-Debug Options
    SQLALCHEMY_ECHO = False
    APP_DEBUG = True

final_parsec_website = Flask('website')