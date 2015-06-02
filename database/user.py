from flask_login import UserMixin
from database import db


class User(UserMixin, db.Model):
    __tablename__ = 'user_account'

    id = db.Column('id', db.Integer, primary_key=True)
    name = db.Column('name', db.String)
    password_hash = db.Column('password_hash', db.String)
    catch_phrase = db.Column('catch_phrase', db.String)

    @staticmethod
    def get(user_id):
        return User.query.get(user_id)


def lookup_user_account_by_name(name):
    return User.query.filter_by(name=name).first()