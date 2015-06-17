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