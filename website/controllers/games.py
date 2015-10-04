from database.post import get_posts_with_tag
from database.tag import get_tag_by_name
from flask import render_template
from website import final_parsec_website


@final_parsec_website.route('/crossdomain.xml')
def get_cross_domain_policy():
    return final_parsec_website.send_static_file('crossdomain.xml')


@final_parsec_website.route('/g/<game_tag_name>')
def landing_page(game_tag_name):
    posts = get_posts_with_tag(game_tag_name)
    tag = get_tag_by_name(game_tag_name)
    return render_template('/pages/games/landing_page.html', posts=posts, tag=tag)