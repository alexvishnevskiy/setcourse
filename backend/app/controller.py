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
