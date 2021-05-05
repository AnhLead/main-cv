import os

import boto3

from flask import Flask
app = Flask(__name__)

client = boto3.client('dynamodb')


@app.route("/hello")
def hello():
    return "hi world"
