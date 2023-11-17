from app import app
from flask import Flask, jsonify, request
from flask_cors import cross_origin
from app.constants import *
from app.controller import *
from http import HTTPStatus


@app.route('/login')
@cross_origin(supports_credentials=True)
def login():
    return 

@app.route('/courses/add/<int:schedule_id>/<int:class_id>', methods=['POST'])
@cross_origin(supports_credentials=True)
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
@cross_origin(supports_credentials=True)
def list_all_classes_for_schedule(schedule_id):
    # list all classes in the given schedule
    classes, status = list_classes_from_schedule(schedule_id)
    if status == SUCCESS:
        return jsonify(classes), HTTPStatus.OK
    else:
        return {}, HTTPStatus.INTERNAL_SERVER_ERROR

@app.route('/class/info/get/<int:class_id>', methods=['GET'])
@cross_origin(supports_credentials=True)
def get_class_info(class_id):
    info, status = class_info(class_id)
    if status == SUCCESS:
        return jsonify(info), HTTPStatus.OK
    elif status == NO_COURSE:
        return jsonify({"message": "No course for this class"}), HTTPStatus.INTERNAL_SERVER_ERROR
    elif status == NO_CLASS:
        return jsonify({"message": "No class"}), HTTPStatus.INTERNAL_SERVER_ERROR
    else:
        return {}, HTTPStatus.INTERNAL_SERVER_ERROR


@app.route('/class/all/get', methods=['GET'])
@cross_origin(supports_credentials=True)
def all_classes():
    search_query = request.args.get('search_query', default=None, type=str)
    core_req = request.args.get('core_req', default=None, type=str)
    days = request.args.get('days', default=None, type=str)

    all_classes, status = get_all_classes(search_query, core_req, days)
    if status != SUCCESS: 
        return {}, HTTPStatus.INTERNAL_SERVER_ERROR
    return jsonify(all_classes), HTTPStatus.OK

@app.route('/schedule/delete/<int:schedule_id>/<int:class_id>', methods=['DELETE'])
@cross_origin(supports_credentials=True)
def delete_class_from_schedule(schedule_id, class_id):
    status = delete_course_from_schedule(schedule_id, class_id)
    if status != SUCCESS:
        return jsonify(status), HTTPStatus.INTERNAL_SERVER_ERROR
    return jsonify(status), HTTPStatus.OK