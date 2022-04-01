from flask import Flask
app = Flask(__name__)


@app.route("/")
def home():
    return "hello"

with app.app_context():
    from routes import admin, customer, order, product


if __name__  == "__main__":
    app.run()
