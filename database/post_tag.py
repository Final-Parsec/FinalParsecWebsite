from database import db
from database.tag import Tag


class PostTag(db.Model):
    __tablename__ = 'post_tag'

    id = db.Column('id', db.Integer, primary_key=True)
    post_id = db.Column('post_id', db.Integer, db.ForeignKey('post.id'))
    tag_id = db.Column('tag_id', db.Integer, db.ForeignKey('tag.id'))
    tag = db.relationship(Tag)

    def add(self):
        db.session.add(self)
        db.session.commit()
        return self