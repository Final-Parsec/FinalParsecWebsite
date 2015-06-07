from database.post import get_posts
from database.user import lookup_user_account_by_name
from flask import abort, render_template
from website import final_parsec_website


@final_parsec_website.route('/')
def index():
    # todo: games
    posts = get_posts()
    return render_template('/pages/blog/index.html', posts=posts)


@final_parsec_website.route('/about/')
def about():
    return render_template('/pages/blog/about.html')


@final_parsec_website.route('/u/<author_name>')
def author(author_name):
    author_user_account = lookup_user_account_by_name(author_name)

    if not author_user_account:
        abort(404)

    return render_template('/pages/blog/author.html', author_user_account=author_user_account)


@final_parsec_website.route('/b/')
def blog():
    posts = get_posts()
    return render_template('/pages/blog/blog.html', posts=posts)


@final_parsec_website.route('/p/<slug>')
def view_post(slug)