from flask import Flask, request, jsonify
from flask_cors import CORS


with open('words.txt') as file:
    words_repository = [w.strip() for w in file.readlines()]


def create_app():
    app = Flask(__name__, instance_relative_config=True)

    word_limit = 10

    @app.route('/words', methods=['GET'])
    def words():
        prefix = request.args.get('prefix', '')
        suffix = request.args.get('suffix', '')
        page = int(request.args.get('page', 1)) - 1
        return jsonify(
            {
                'result': [
                    word for word in words_repository
                    if word.startswith(prefix)
                    and word.endswith(suffix)
                ][word_limit * page: word_limit * (page + 1)]
            }
        )

    CORS(app)

    return app


if __name__ == '__main__':
    create_app().run()
