from database.user import User
from flask import g, render_template, request, redirect, url_for
from flask.ext.login import login_required, login_user, logout_user
from flask.ext.wtf import Form
from website import final_parsec_website
from werkzeug.security import check_password_hash, generate_password_hash
from wtforms import HiddenField


class LoginForm(Form):
    next = HiddenField('next')


@final_parsec_website.route('/saxophone_baby_mattress/password/', methods=['GET', 'POST'])
@login_required
def change_password():
    error_message = None

    if request.method == 'POST':
        user = User.get(g.user.id)
        original_password = request.form.get('original_password')
        new_password = request.form.get('new_password')

        if new_password != request.form.get('new_password_check'):
            error_message = 'New passwords do not match.'
        elif not check_password_hash(user.password_hash, original_password):
            error_message = 'Your password is not correct.'
        elif len(new_password) < 8:
            error_message = 'New password must be at least 8 characters.'
        else:
            user.password_hash = generate_password_hash(new_password)
            user.save_changes()
            return render_template('/pages/user_account/change_password_success.html')

    return render_template('/pages/admin/change_password.html', error_message=error_message)


@final_parsec_website.route('/saxophone_baby_mattress/log_in/', methods=['GET', 'POST'])
def log_in():
    error_message = None

    if g.user is not None and g.user.is_authenticated():
        return redirect(url_for('post_list'))

    if request.method == 'POST':
        user_name = request.form.get('user_name')
        user = User.query.filter_by(name=user_name).first()

        if user is not None and check_password_hash(user.password_hash, request.form.get('password')):
            login_user(user, remember=True)
            return redirect(request.form.get('next') or url_for('post_list'))
        else:
            error_message = 'User name or password incorrect. Please try again.'

    login_form = LoginForm()
    login_form.next.data = request.args.get('next')
    return render_template('pages/admin/log_in.html', error_message=error_message, form=login_form)


@final_parsec_website.route('/saxophone_baby_mattress/log_out/')
@login_required
def log_out():
    logout_user()
    return redirect(url_for('log_in'))


@final_parsec_website.route('/saxophone_baby_mattress/')
@login_required
def post_list():
    """
        Lists all posts in the blog.

        Acts as the home page for admin area.
    """
    return render_template('pages/admin/post_list.html')