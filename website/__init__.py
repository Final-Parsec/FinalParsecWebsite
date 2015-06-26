from database import init_database
from datetime import timedelta
from flask import Flask, g, render_template, session
from flask.ext.login import LoginManager, current_user
from time import time
from website import jinja_filters
from website.configuration import Config

final_parsec_website = Flask('website')

final_parsec_website.config.from_object(Config)
final_parsec_website.debug = final_parsec_website.config['APP_DEBUG']

final_parsec_website.jinja_env.filters['pretty_date'] = jinja_filters.pretty_date

init_database(final_parsec_website, g)


@final_parsec_website.errorhandler(500)
def page_error(error):
    """
    User is displayed this page if an error occurs when attempting to render page.
    """
    return render_template('error_pages/500.html', error=error), 500


@final_parsec_website.errorhandler(404)
def page_missing(error):
    """
    User is displayed this page if they attempt to go to a URL that doesn't exist.
    """
    return render_template('error_pages/404.html', error=error), 404


@final_parsec_website.before_request
def before_request():
    # Setup session timeout.
    session.permanent = True
    session.permanent_session_lifetime = timedelta(minutes=30)
    g.user = current_user

    # Record request time.
    g.request_start_time = time()
    g.request_time = lambda: "%.5fs" % (time() - g.request_start_time)

    g.debug = final_parsec_website.debug

    from database.tag import get_game_tags
    g.game_tags = get_game_tags()

login_manager = LoginManager()
login_manager.init_app(final_parsec_website)
login_manager.login_view = 'log_in'
login_manager.login_message = ''


@login_manager.user_loader
def load_user(user_id):
    from database.user import User
    return User.get(user_id)

from website.controllers import *