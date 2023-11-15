import Button from '../components/Button';
import Calendar from '../components/Calendar';
import Header from '../components/Header'; 
import Sidebar from '../components/Sidebar'; 
import DeleteCourseModal from '../components/DeleteCourseModal'; 
import { BiPlus } from 'react-icons/bi';
import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom'; 
import CourseInfoModal from '../components/CourseInfoModal';

function Home({ courses, setCourses, scheduleID}) {
    const [openDeleteModal, setOpenDeleteModal] = useState(false); 
    const [itemToDelete, setItemToDelete] = useState(undefined); 

    const [openCourseInfoModal, setOpenCourseInfoModal] = useState(false); 
    const [courseInfo, setCourseInfo] = useState(undefined); 

    const infoModalHandler = () => {
        setCourseInfo(undefined); 
        setOpenCourseInfoModal(prevState => !prevState);
    }

    const getCourseInfo = (course_id) => {
        //get the course info based on course_id
        new Promise((resolve) => {
            setTimeout(() => {
                resolve({
                    'title': 'COEN 177', 
                    'units': '4',
                    'name': 'Operating Systems', 
                    'co-requisites': 'COEN 177L - Operating Systems Lab', 
                    'description': 'Introduction to computer operating systems. Operating system concepts, computer organization model, storage hierarchy, operating system organization, processes management, interprocess communication and synchronization, memory management and virtual memory, I/O subsystems, and file systems. Design, implementation, and performance issues.',
                    'professor': 'Ahmed Amer', 
                    'time': '11AM - 12:05PM', 
                    'location': "O'Conner 207", 
                    'id': 10
                }); 
            }, 1000);
        })
        .then((data) => {
            setCourseInfo(data);
        })
        .then(() => {
            setOpenCourseInfoModal(!openCourseInfoModal); 
        })
    }

    const onConfirmDelete = () => {
        //send request to database to remove class (schedule_id & class_id)
        //on success (call setCourses)
        const newEvents = courses.events.filter((event) => event.id !== itemToDelete.id);
        new Promise((resolve, reject) => {
            setTimeout(() => {
                resolve(); 
            }, 1000);
        })
        .then(() => {
            setCourses({events: newEvents});
            setItemToDelete(undefined);
            setOpenDeleteModal(prevState => !prevState); 
        })
        .catch(() => {  
            setItemToDelete(undefined);
            setOpenDeleteModal(prevState => !prevState); 
        })
    }   

    const config = {
        viewType: "Resources",
        startDate: "2023-11-02", 
        columns: [
            {name: "mon", id: "M"},  
            {name: "tue", id: "T"},  
            {name: "wed", id: "W"},  
            {name: "thu", id: "TH"},  
            {name: "fri", id: "F"},  
            {name: "sat", id: "SA"},  
            {name: "sun", id: "SU"},  
        ],  
        timeRangeSelectedHandling: "Disabled",
        eventMoveHandling: "Disabled",
        eventResizeHandling: "Disabled",
        eventClickHandling: "Disabled",
        eventHoverHandling: "Disabled",
        cellHeight: 45, //dont change this value
        durationBarVisible: false, 
        useEventBoxes: "ShortEventsOnly",
        eventDeleteHandling: "Callback",
        onEventDeleted: (args) => {
            setItemToDelete(args.e.data); 
            setOpenDeleteModal(!openDeleteModal);
        },
    };

    function formatTimeString(dateTimeString) {
        const options = { hour: 'numeric', minute: 'numeric' };
        const formattedTime = new Date(dateTimeString).toLocaleTimeString([], options);
        return formattedTime.split(" ")[0];
    } 

    //Runs on page load: gets users classes in their schedule & gets all the classes in the database
    useEffect(() => {
        //get users courses
        fetch(`http://127.0.0.1:8080/schedule/classes/get/${scheduleID}`)
        .then(response => {
            if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json();
        })
        .then((classes) => {
            const classesArr = [];
            for(let singleClass of classes){
                const startTime = formatTimeString(`2023-11-02T${singleClass.start}:00`);
                const endTime = formatTimeString(`2023-11-02T${singleClass.end}:00`);
                const classObj = {
                    'resource': singleClass.days,
                    'start': `2023-11-02T${singleClass.start}:00`,
                    'end': `2023-11-02T${singleClass.end}:00`,
                    'text': `${singleClass.title}\n${startTime}-${endTime}`,
                    'title': singleClass.title,
                    'id': singleClass.class_id
                }
                classesArr.push(classObj);
            }
            setCourses({
                events: classesArr
            })
        })
        .catch(error => {
            console.error('Fetch error:', error);
        });
    }, []);

    const convertCoursesToCalendarFormat = (coursesList) => {
        if(coursesList.length <= 0) return coursesList; 
        const classesFormatted = {
            events: []
        }
        for(let i = 0; i < coursesList.length; i++){
            const daysOffered = coursesList[i].resource.split('/');
            for(let day of daysOffered){
                let newClass = { ...coursesList[i] };
                newClass.resource = day;
                classesFormatted.events.push(newClass);
            }
        }
        return classesFormatted;
    }

    return (
      <div className="vh-100 d-flex flex-column position-relative" style={{backgroundColor: "#F2EDFF", backgroundImage: "url('/homeBackground.png')", backgroundPosition: "right bottom", backgroundRepeat: "no-repeat"}}>
        {openDeleteModal && <DeleteCourseModal setOpenDeleteModal={setOpenDeleteModal} onConfirmDelete={onConfirmDelete} itemToDelete={itemToDelete}/>}
        {openCourseInfoModal && <CourseInfoModal courseInfo={courseInfo} btnInfo={[
            {
                clickHandler: infoModalHandler,
                btnText: 'Close'
            }
        ]} btnText={"Close"}/>}
        <Header /> 
        <div className="m-3 p-0 d-flex row gap-2" style={{flex: 1}}> 
            <Sidebar courses={courses.events} getCourseInfo={getCourseInfo}/> 
            <div className="p-0 m-0 main col d-flex flex-column">
                <div className="d-flex justify-content-between align-items-center mb-3">
                    <h5 className="m-0 p-0 w-auto fw-bold text-dark">Schedule</h5>
                    <Link to="/search" className="text-reset m-0 p-0 w-auto d-flex gap-2" style={{
                        textDecoration: 'none'
                    }}>
                        <Button text="Add Course" icon={<BiPlus />} color={"#44DB56"} />
                    </Link>
                </div>
                <div className="calendar m-0 p-0" style={{flex: 1}}>
                    <Calendar config={config} courses={convertCoursesToCalendarFormat(structuredClone(courses.events))}/>
                </div>
            </div>
        </div>
      </div>
    );
  }
  
export default Home;