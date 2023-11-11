import os
from app import app
from flask import Flask, jsonify, request
from app.constants import *
from app.controller import *
from http import HTTPStatus
# from flask_cors import CORS

# CORS(app, resources={r"/class/info/*": {"origins": "http://127.0.0.1:3000"}})

@app.route('/login')
def login():
    return 

@app.route('/courses/add/<int:schedule_id>/<int:class_id>', methods=['POST'])
def add_course(schedule_id, class_id):
    # add course to specific scheduler
    status = add_class2schedule(schedule_id, class_id)
    # check for error
    if status == SUCCESS:
        return jsonify({"message": "Course added successfully!"}), HTTPStatus.CREATED
    elif status == NO_SCHEDULE_OR_CLASS:
        return jsonify({"message": f"No schedule or class with these schedule_id: {schedule_id}, class_id: {class_id}"}), HTTPStatus.INTERNAL_SERVER_ERROR
    elif status == TIME_CONFLICT:
        return jsonify({"message": "Time conflict"}), HTTPStatus.INTERNAL_SERVER_ERROR
    elif status == NOT_ENOUGH_UNITS:
        return jsonify({"message": "Not enough units"}), HTTPStatus.INTERNAL_SERVER_ERROR
    elif status == CLASS_EXISTS:
        return jsonify({"message": "Class already exists"}), HTTPStatus.INTERNAL_SERVER_ERROR
    else:
        return jsonify({"message": f"Internal error"}), HTTPStatus.INTERNAL_SERVER_ERROR

@app.route('/schedule/classes/get/<int:schedule_id>', methods=['GET'])
def list_all_classes_for_schedule(schedule_id):
    # list all classes in the given schedule
    classes, status = list_classes_from_schedule(schedule_id)
    if status == SUCCESS:
        return jsonify(classes), HTTPStatus.OK
    else:
        return {}, HTTPStatus.INTERNAL_SERVER_ERROR

@app.route('/class/info/get/<int:class_id>', methods=["GET", "OPTIONS"])
def get_class_info(class_id):
    info, status = class_info(class_id)
    # return jsonify(info), status
    response = jsonify(info)
    
    return response

# @app.route('/courses/delete/<int:schedule_id>/<int:class_id>', methods=['DELETE'])
# def delete_course(schedule_id, class_id):
#     # delete course from specific scheduler
#     return

# @app.route('/reviews/add/<int:professor_id>/<int:class_id>', methods=['POST'])
# def add_review():
#     # add review
#     return

# @app.route('/reviews/delete/<int:professor_id>/<int:class_id>', methods=['DELETE'])
# def delete_review():
#     # delete review
#     return

# @app.route('/schedule/create/<int:user_id>/<str:term>', methods=['POST'])
# def create_schedule():
#     # create schedule
#     return

# @app.route('/schedule/delete/<int:user_id>/<str:term>', methods=['DELETE'])
# def delete_schedule():
#     # delete schedule
#     return

# @app.route('/schedule/get/<int:user_id>', methods=['GET'])
# def list_all_schedules():
#     # list all schedules for specific user
#     return

# @app.route('/reviews/get/<int:professor_id>/<int:class_id>', methods=['GET'])
# def list_all_reviews():
#     # list all reviews
#     return

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))    
    app.run(host='0.0.0.0', port=port)
