from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello_world():
    return "Hello, World!"


@app.route("/ahla-messa")
def ahla_messa():
    return "Ahla Messa from abo hany!"


@app.route("/after-modify")
def after_modify():
    return "After modify!"


if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", port=5000)
