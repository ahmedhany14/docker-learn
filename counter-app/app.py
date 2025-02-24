import time
import redis
from flask import Flask


app = Flask(__name__)

cash = redis.Redis(host="redis", port=6379, db=0)


def count_hits():
    tries = 5

    while tries > 0:
        try:
            return cash.incr("hits")
        except Exception as e:
            print(e)
            tries -= 1
            time.sleep(.5)


@app.route("/")
def hello_world():
    count = count_hits()
    return f"Hello, World! This page has been visited {count} times."


if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", port=5000)
