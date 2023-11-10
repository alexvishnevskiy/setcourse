from app.repository import *
from app.constants import *


def add_class2schedule(scheduleID, classID):
    class_, status = getClass(classID)
    if status != SUCCESS:
        return status

    classTime = class_.time # class time
    classesID, status = getClassesFromSchedule(scheduleID) # all classes for this schedule
    if status != SUCCESS:
        print("No classes for this schedule")
    
    # check time conflict
    for cl_id in classesID:
        # TODO: redo in future
        cl_, status = getClass(cl_id)
        if status != SUCCESS:
            return status
        if cl_.time == classTime:
            return TIME_CONFLICT

    # calculate total units for all courses in schedule
    classesID += [class_.cl_id]
    total_units = 0
    for cl_id in classesID:
        course_, status = getCourseFromClass(cl_id)
        if status != SUCCESS:
            return status
        total_units += course_.units

    if total_units > MAX_UNITS:
        return NOT_ENOUGH_UNITS

    # add class to schedule
    status = addClassToSchedule(scheduleID, classID)
    return status

def list_classes_from_schedule(scheduleID):
    # return format: [{'days': 'MWF', 'start': 10:00, 'end': 13:00, 'title': 'COEN', 'course_id': 1}, {}, {}]
    all_classes = []
    classesID, status = getClassesFromSchedule(scheduleID) # all classes for this schedule
    if status != SUCCESS:
        print("No classes for this schedule")
        return all_classes, status

    for classID in classesID:
        # get detauls for course
        course_, status = getCourseFromClass(classID)
        if status != SUCCESS:
            return [], status
        # get details for class
        class_, status = getClass(classID)
        if status != SUCCESS:
            return [], status

        start_time = class_.time.split('-')[0]
        end_time = class_.time.split('-')[1]
        all_classes.append(
            {
                'days': class_.days,
                'start': start_time, #TODO: change later
                'end': end_time,
                'title': course_.name,
                'course_id': course_.c_id
            }
        )
    return all_classes, SUCCESS

def class_info(classID):
    # course information
    course_info, status = getCourseFromClass(classID)
    if status != SUCCESS:
        return {}, status

    # class information
    class_info, status = getClass(classID)
    if status != SUCCESS:
        return {}, status
    
    # professor info
    professor_details, status = getProfessorFromClass(class_info.cl_id)
    if status != SUCCESS:
        return {}, status

    start_time = class_info.time.split('-')[0]
    end_time = class_info.time.split('-')[1]
    
    return {
        'title': course_info.title,
        'units': course_info.units,
        'name': course_info.name,
        'co-requisites': course_info.co_reqs,
        'description': class_info.description, 
        'professor': professor_details.first_name + ' ' + professor_details.last_name,
        'start': start_time,
        'end': end_time,
        'location': class_info.location,
        'course_id': course_info.c_id
    }, SUCCESS

