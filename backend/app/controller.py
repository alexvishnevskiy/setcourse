from app.repository import *
from app.constants import *
import random
from datetime import datetime


# internal function to split start and end times
def _split_time(time: str):
    start_time = time.split('-')[0].strip()
    end_time = time.split('-')[1].strip()
    return start_time, end_time

def _split_days(days: str):
    return days.split('/')

def _do_classes_overlap(s1, e1, s2, e2):
    format_str = "%H:%M"
    class1_start = datetime.strptime(s1, format_str)
    class1_end = datetime.strptime(e1, format_str)
    class2_start = datetime.strptime(s2, format_str)
    class2_end = datetime.strptime(e2, format_str)

    return max(class1_start, class2_start) < min(class1_end, class2_end)

def add_class2schedule(scheduleID, classID):
    class_, status = getClass(classID)
    if status != SUCCESS:
        return status
    
    classTime = class_.time # class time
    classesID, status = getClassesFromSchedule(scheduleID) # all classes for this schedule
    if status != SUCCESS:
        print("No classes for this schedule")
        
    # check for time conflict (time conflict occurs when times overlap on the same day). If there is a time conflict remove the conflicting courses and add the class the user wants to add to the schedule.
    conflictingClasses = []
    nonConflictingClasses = []
    classToAddDays = _split_days(class_.days)
    for cl_id in classesID:
        cl_, status = getClass(cl_id)
        #check if they occur on the same day
        specificClassDays = _split_days(cl_.days)
        #if the occcur on same day check if times overlap
        if any(day in specificClassDays for day in classToAddDays):
            print('Class is on the same day')
            s1,e1 = _split_time(class_.time)
            s2,e2 = _split_time(cl_.time)
            # if classes overlap
            if(_do_classes_overlap(s1,e1,s2,e2)):
                print('Times conflict')
                conflictingClasses.append(cl_.cl_id)
        if(cl_.cl_id not in conflictingClasses):
            nonConflictingClasses.append(cl_.cl_id)
    # check if any of the non conflicting classes are of the same course
    coursesInSchedule = []
    print('conflicting classe ID:', conflictingClasses)
    print('NON-conflicting classe ID:', nonConflictingClasses)
    for cl_id in nonConflictingClasses:
        cl_, status = getClass(cl_id)
        coursesInSchedule.append(cl_.c_id)
    if class_.c_id in coursesInSchedule:
        return CLASS_EXISTS
    
    # remove conflicting classes
    if(len(conflictingClasses) > 0):
        for specificClassID in conflictingClasses:
            status = delete_course_from_schedule(scheduleID, specificClassID)
            if status != SUCCESS:
                return status
        

    # calculate total units for all courses in schedule
    # classesID += [class_.cl_id]
    # total_units = 0
    # for cl_id in classesID:
    #     course_, status = getCourseFromClass(cl_id)
    #     if status != SUCCESS:
    #         return status
    #     total_units += course_.units

    # if total_units > MAX_UNITS:
    #     return NOT_ENOUGH_UNITS

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

        start_time, end_time = _split_time(class_.time)
        all_classes.append(
            {
                'days': class_.days,
                'start': start_time, 
                'end': end_time,
                'title': course_.title,
                'class_id': class_.cl_id
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
    print('class info:', class_info)
    if status != SUCCESS:
        return {}, status
    
    # professor info
    professor_details, status = getProfessorFromClass(class_info.cl_id)
    if status == NO_PROFESSOR:
        print('No professor for this class')
        professor_details = models.Professors(first_name = '', last_name = '')
    elif status != SUCCESS:
        return {}, status

    start_time, end_time = _split_time(class_info.time)
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
        'class_id': class_info.cl_id,
        'days': class_info.days
    }, SUCCESS

# Get all the classes in the database
def get_all_classes(search_query=None, core_req=None, days=None):
    classes, status = getAllClasses(search_query, core_req, days)
    if status != SUCCESS:
        return [], status

    all_classes = []
    for class_ in classes:
        # professor info
        professor_details, status = getProfessorFromClass(class_.cl_id)
        if status == NO_PROFESSOR:
            print('No professor for this class')
            professor_details = models.Professors(first_name = '', last_name = '')

        start_time, end_time = _split_time(class_.time)
        all_classes.append({
            'title': class_.course.title,
            'name': class_.course.name,
            'professor': professor_details.first_name + ' ' + professor_details.last_name,
            'start': start_time,
            'end': end_time,
            'seats': class_.total_seats,
            'class_id': class_.cl_id,
            'days': class_.days
        })
    return all_classes, SUCCESS

# Delete course given schedule_id and course_id
def delete_course_from_schedule(scheduleID, classID):
    status = deleteCourseFromSchedule(scheduleID, classID)
    return status

