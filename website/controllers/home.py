from database.post import get_posts
from flask import render_template
from website import final_parsec_website



@final_parsec_website.route('/')
def index():
    posts = get_posts()
    return render_template('/pages/home/index.html', posts=posts)