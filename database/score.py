from database import db


class Score(db.Model):
    __tablename__ = 'score'
    id = db.Column(db.Integer, primary_key=True)
    player_name = db.Column(db.Text)
    score = db.Column(db.Integer)
    leaderboard_name = db.Column(db.String(100))

    def add(self):
        db.session.add(self)
        db.session.commit()
        return self