from database.score import Score
from flask import jsonify, render_template, request
from website import final_parsec_website


@final_parsec_website.route('/leaderboards/')
def view_leaderboards():
    # todo: sweet ajaxy page where you can view all leaderboards and rankings
    return render_template('/pages/leaderboards/view.html')


@final_parsec_website.route('/scores/<leaderboard_name>', methods=['GET', 'POST'])
def leaderboard_scores(leaderboard_name):
    limit = request.args.get('limit', None)
    player_name = request.args.get('player_name', None)
    score = request.args.get('score', None)

    if player_name and score and leaderboard_name:
        new_score = Score()
        new_score.player_name = player_name
        new_score.score = score
        new_score.leaderboard_name = leaderboard_name
        new_score.add()

    json_results = []

    results = Score.query.filter_by(leaderboard_name=leaderboard_name).order_by(Score.score.desc())

    if limit:
        results = results.limit(limit)

    rank = 0
    for result in results.all():
        rank += 1
        d = {'rank': rank,
             'player_name': result.player_name,
             'score': result.score}
        json_results.append(d)

    return jsonify(competitors=json_results)