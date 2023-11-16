from app import db, models
from app.constants import *
from sqlalchemy.exc import IntegrityError
from sqlalchemy import or_, and_


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
        return [], NO_CLASSES_FOR_THIS_SCHEDULE
    return [sch2class.cl_id for sch2class in schedule2class], SUCCESS

def getProfessorFromClass(classId):
    professor2class = models.Teach.query.filter_by(cl_id=classId).all()
    if professor2class is None:
        return None, NO_CLASS

    professor = models.Professors.query.get(professor2class[0].pr_id)
    if professor is None:
        return None, NO_PROFESSOR
    return professor, SUCCESS

def getAllClasses(search_query=None, core_req=None, days=None):
    # get all classes with or without filters
    classesWithDetails = models.Classes.query.join(models.Course)

    if core_req is not None:
        classesWithDetails = classesWithDetails.filter(and_(*[models.Course.core_req.like(f"%{core}%") for core in core_req]))
    if days is not None:
        print('days:', days[0])
        classesWithDetails = classesWithDetails.filter(and_(*[models.Classes.days.like(f"%{days[0]}%")]))
    if search_query is not None:
        classesWithDetails = classesWithDetails.filter(
            or_(
                models.Course.name.op('REGEXP')(f"{search_query}"),
                models.Course.title.op('REGEXP')(f"{search_query}")
            )
        )

    if classesWithDetails is None:
        return None, NO_CLASS
    return classesWithDetails, SUCCESS

def deleteCourseFromSchedule(scheduleId, classId):
    entry_to_delete = models.Schedule2Class.query.filter_by(cl_id=classId, sch_id=scheduleId).first()
    if entry_to_delete:
        db.session.delete(entry_to_delete)
        db.session.commit()
        return SUCCESS
    else:
        return NO_SCHEDULE_OR_CLASS