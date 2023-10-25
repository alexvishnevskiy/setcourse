from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config.from_object('app.configuration.Config')

db = SQLAlchemy(app) #flask-sqlalchemy

from app import models
