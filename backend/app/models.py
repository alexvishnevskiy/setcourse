from app import db
from enum import Enum

class ChoiceEnum(Enum):
    OPTION_1 = "Fall"
    OPTION_2 = "Winter"
    OPTION_3 = "Spring"
    OPTION_4 = "Summer"

class User(db.Model):
    user_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(100), nullable=False)
    last_name = db.Column(db.String(100), nullable=False)
    schedules = db.relationship('Schedule', backref='user', lazy=True)

class Schedule(db.Model):
    sch_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.user_id'), nullable=False)
    term = db.Column(db.Enum(ChoiceEnum), nullable=False)
    classes = db.relationship('Schedule2Class', backref='schedule', lazy=True)
    
class Course(db.Model):
    c_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    classes = db.relationship('Classes', backref='course', lazy=True)

class Classes(db.Model):
    cl_id = db.Column(db.Integer, primary_key=True)
    time = db.Column(db.String(50), nullable=False)
    term = db.Column(db.Enum(ChoiceEnum), nullable=False)
    c_id = db.Column(db.Integer, db.ForeignKey('course.c_id'), nullable=False)
    reviews = db.relationship('Reviews', backref='classes', lazy=True)
    professor = db.relationship('Teach', backref='classes', lazy=True)
    schedules = db.relationship('Schedule2Class', backref='classes', lazy=True)

class Reviews(db.Model):
    # TODO: check for 1..n
    pr_id = db.Column(db.Integer, db.ForeignKey('professors.pr_id'), primary_key=True)
    cl_id = db.Column(db.Integer, db.ForeignKey('classes.cl_id'), primary_key=True)
    review = db.Column(db.Text, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.user_id'), nullable=False)

class Professors(db.Model):
    pr_id = db.Column(db.Integer, primary_key=True)
    first_name = db.Column(db.String(100), nullable=False)
    last_name = db.Column(db.String(100), nullable=False)
    reviews = db.relationship('Reviews', backref='professors', lazy=True)
    classes = db.relationship('Teach', backref='professors', lazy=True)

class Teach(db.Model):
    pr_id = db.Column(db.Integer, db.ForeignKey('professors.pr_id'), primary_key=True)
    cl_id = db.Column(db.Integer, db.ForeignKey('classes.cl_id'), primary_key=True)

class Schedule2Class(db.Model):
    cl_id = db.Column(db.Integer, db.ForeignKey('classes.cl_id'), primary_key=True)
    sch_id = db.Column(db.Integer, db.ForeignKey('schedule.sch_id'), primary_key=True)