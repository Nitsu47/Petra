#!/bin/bash/env
from flask import Flask
from markupsafe import escape


app = Flask(__name__)

@app.route("/")
def hello():
    return "<p>Hola</p>"

@app.route("/name/<name>")
def hello_name(name="Petra"):
  return f"Hello {escape(name)}"

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)