from app import db, models
from app.constants import *
from sqlalchemy.exc import IntegrityError


def addClassToSchedule(scheduleID, classID):
    # add data to schedule2class table
    schedule_to_class = models.Schedule2Class(cl_id=classID, sch_id=scheduleID)
    db.session.add(schedule_to_class)

    # check for existing keys and if there are no cl_id or sch_id
    try:
        db.session.commit()
        return SUCCESS
    except IntegrityError as e:
        db.session.rollback()
        if 'foreign key constraint fails' in str(e.orig).lower():
            return NO_SCHEDULE_OR_CLASS
        else:
            return CLASS_EXISTS            

def getSectionDetails(sectionID):
    pass

def getProfDetails(professorID):
    pass

def getSchedule(scheduleID):
    # query schedule details
    schedule = models.Schedule.query.get(scheduleID)
    if schedule is None:
        return None, NO_SCHEDULE
    return schedule, SUCCESS

def getClass(classID):
    # query class details
    class_ = models.Classes.query.get(classID)
    if class_ is None:
        return None, NO_CLASS
    return class_, SUCCESS

def getCourse(courseID):
    # query course details
    course = models.Course.query.get(courseID)
    if course is None:
        return None, NO_COURSE
    return course, SUCCESS

def getCourseFromClass(classID):
    # query course details
    classes = models.Classes.query.filter_by(cl_id=classID).all()
    if classes is None:
        return None, NO_COURSE

    course, status = getCourse(classes[0].c_id)
    if status != SUCCESS:
        return None, status
    return course, SUCCESS

def getClassesFromSchedule(scheduleID):
    # return classes_id
    schedule2class = models.Schedule2Class.query.filter_by(sch_id=scheduleID).all()
    if schedule2class is None:
        return None, NO_CLASSES_FOR_THIS_SCHEDULE
    return [sch2class.cl_id for sch2class in schedule2class], SUCCESS

def createNewSchedule():
    pass

def addSection(sectionID):
    pass

def addReview(quality, difficulty, description, sectionID):
    pass

def deleteSchedule(scheduleID):
    pass

def deleteSection(sectionID, scheduleID):
    pass

def sectionTaken(sectionID):
    pass