from database import db


class Tag(db.Model):
    __tablename__ = 'tag'

    id = db.Column('id', db.Integer, primary_key=True)
    name = db.Column('name', db.String)
    game_name = db.Column('game_name', db.String)

    def add(self):
        db.session.add(self)
        db.session.commit()
        return self


def get_tag_by_name(name):
    return Tag.query.filter_by(name=name).first()


def get_game_tags():
    # Equality operator usage is intentional. "is not None" doesn't work here.
    return Tag.query.filter(Tag.game_name != None).order_by(Tag.game_name)