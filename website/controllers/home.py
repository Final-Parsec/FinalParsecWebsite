from database import save_changes
from database.post import get_posts, Post
from database.user import User
from datetime import date
from flask import g, render_template, request, redirect, url_for
from flask.ext.login import login_required, login_user, logout_user
from website import final_parsec_website
from werkzeug.security import check_password_hash, generate_password_hash


@final_parsec_website.route('/')
def index():
    return render_template('/pages/home/index.html')