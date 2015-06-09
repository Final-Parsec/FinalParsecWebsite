from database.post import get_post_by_slug, get_posts, Post
from database.user import lookup_user_account_by_name
from datetime import date
from flask import abort, Markup, render_template
from flask.ext.login import current_user
from markdown import markdown
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

    authored_posts = get_posts(current_user.is_authenticated()).filter_by(author_id=author_user_account.id)

    return render_template('/pages/blog/author.html', authored_posts=authored_posts, author_user_account=author_user_account)


@final_parsec_website.route('/b/')
def blog():
    posts = get_posts()
    return render_template('/pages/blog/blog.html', posts=posts)


@final_parsec_website.route('/p/<slug>')
def view_post(slug):
    # todo: tags and related posts

    post = None
    if slug:
        post = get_post_by_slug(slug)
    assert type(post) is Post

    if (post.publish_date > date.today() or post.is_draft) and not current_user.is_authenticated():
        abort(404)

    post.content = Markup(markdown(post.content))

    author_user_account = post.author

    return render_template('/pages/blog/post.html', author_user_account=author_user_account, post=post)