import os
from app import app
from flask import Flask, jsonify, request
from app.constants import *
from app.controller import *
from http import HTTPStatus

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
        return jsonify({"message": f"Internal error: {status.__str__}"}), HTTPStatus.INTERNAL_SERVER_ERROR

if __name__ == "__main__":
	port = int(os.environ.get("PORT", 8080))
	app.run(host='0.0.0.0', port=port)
