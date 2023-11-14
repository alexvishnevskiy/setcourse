from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS, cross_origin

app = Flask(__name__)
app.config.from_object('app.configuration.Config')
CORS(app, support_credentials=True)

db = SQLAlchemy(app) #flask-sqlalchemy

from app import models
