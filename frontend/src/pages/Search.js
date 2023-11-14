import Button from '../components/Button';
import CourseList from '../components/CourseList';
import Header from '../components/Header'; 
import SearchBar from '../components/SearchBar';
import SearchSidebar from '../components/SearchSidebar';
import Notification from '../components/Notification';
import { BiCalendar } from 'react-icons/bi';
import React, { useState, useEffect } from 'react';
import CourseInfoModal from '../components/CourseInfoModal';
import { Link } from 'react-router-dom'; 
import CourseConflictModal from '../components/CourseConflictModal';

/*
TODO: 
- Make a course have a check mark if it is already in the schedule
- Implement filters (save state)
- Function to display times nicely
*/

function Search({courses, setCourses}) {
    //Holds information about the users search query 
    const [searchQuery, setSearchQuery] = useState('');
    const [searchResult, setSearchResult] = useState(undefined); 

    //Holds information about the class information a user clicks on
    const [openCourseInfoModal, setOpenCourseInfoModal] = useState(false);
    const [courseInfo, setCourseInfo] = useState(undefined); 

    //Holds information about conflicting courses 
    const [openCourseConflictModal, setOpenCourseConflictModal] = useState(false);
    const [conflictCourses, setConflictCourses] = useState(undefined); 

    //Holds status of whether adding class to schedule succeeded or failed
    const [showStatus, setShowStatus] = useState(false); 
    const [status, setStatus] = useState(false); 

    const tempDB = [{
        'title': 'MATH 122', 
        'units': '5',
        'name': 'Probability & Statistics 1', 
        'co-requisites': 'N/A', 
        'description': 'Sample spaces; conditional probability; independence; random variables; discrete and continuous probability distributions; expectation; moment-generating functions; weak law of large numbers; central limit theorem.',
        'professor': 'Robert Bekes', 
        "start": "T14:00:00",
        "end": "T15:20:00",
        'location': "O'Conner 205",
        'seats': 13, 
        'id': 1
    },
    {
        'title': 'RSOC 128', 
        'units': '5',
        'name': 'Religion & Popular Culture', 
        'co-requisites': 'N/A', 
        'description': 'Examines the relationships between religious practice and culture expressions understood as appealing to the non-elite masses through various media (print, television, movies, music, etc.), personages (religious celebrities, entertainment celebrities, sports stars), embodied expressions and enhancements (clothing, jewelry, tattoos, piercings, etc.) and other material forms (mugs, water bottles, statues, posters, etc.). Considers how depictions of religion in popular culture forms affects how we understand religious experiences, practitioners, and communities and how religion itself functions as an element of cultural production that contributes to popular interest.',
        'professor': 'Elizabeth Drescher', 
        "start": "T08:15:00",
        "end": "T09:20:00",
        'location': "Kenna Hall 311",
        'seats': 10, 
        'id': 2
    }]

    //Runs on page load: gets users classes in their schedule & gets all the classes in the database
    useEffect(() => {
        //get users courses
        setTimeout(() => {
            setCourses({
                events: [
                    {
                        "resource": "M/W/F",
                        "start": "2023-11-02T14:15:00",
                        "end": "2023-11-02T15:20:00",
                        "text": "COEN 177\n2:15-3:20", 
                        "title": "COEN 177",
                        "id": 1, 
                    },
                    {
                        "resource": "T/TH",
                        "start": "2023-11-02T16:15:00",
                        "end": "2023-11-02T17:23:00",
                        "text": "MUSC 7\n4:15-5:23",
                        "title": "MUSC 7",
                        "id": 2, 
                    },
                ]
            });
        }, 1000);
        //send request to get all classes for current term, place in search result state 
        console.log("Request sent for classes in schedule");
        console.log("Request sent for all classes in DB");
    }, []);

    //Runs when user clicks search. 
    const onSearch = () => {
        //sends request to API with searchQuery, gets back result 
        console.log("Your Search Query:", searchQuery); 
        const result = tempDB;
        setSearchResult(result);
        setSearchQuery(''); 
    }

    //Runs when a user clicks on a class listing to view info
    const handleShowCourseInfo = (course_id) => {
        console.log("View Course Info for course with ID:", course_id);
        new Promise((resolve) => {
            setTimeout(() => {
                resolve(tempDB.find((item) => item.id === course_id)); 
            }, 100);
        })
        .then((data) => {
            setCourseInfo(data);
            setOpenCourseInfoModal(prevState => !prevState);
        })
    }

    //Runs after verifying class repalcement or simply adding a course
    const completeAddingCourse = (course_id) => {
        //add course using API endpoint
        setStatus(true); 
        setShowStatus(true); 
        setCourseInfo(undefined);
        openCourseInfoModal && setOpenCourseInfoModal(prevState => !prevState); 
        setConflictCourses(undefined); 
        openCourseConflictModal && setOpenCourseConflictModal(prevState => !prevState); 
    }

    //Checks to see if the class the user wants to add conflicts with a class already in their schedule
    const checkIfTimingOverlap = (course_id) => {
        //get the course
        const fetchedClass = tempDB.find((item) => item.id === course_id);
        //check time conflict (which classes it conflicts with)
        let classConflicts = []; 
        for(let i = 0; i < courses.events.length; i++){
            const startInterval = new Date(courses.events[i].start).getTime();
            const endInterval = new Date(courses.events[i].end).getTime();
            const targetStart = new Date("2023-11-02" + fetchedClass.start).getTime();
            const targetEnd = new Date("2023-11-02" + fetchedClass.end).getTime();
            if(startInterval <= targetEnd && targetEnd <= endInterval || targetStart <= endInterval && endInterval <= targetEnd){
                classConflicts.push(courses.events[i].title);
            }
        }
        //if conflict enable modal
        if(classConflicts.length > 0){
            setConflictCourses({
                'parent': fetchedClass, 
                'conflicts': classConflicts,
            });
            if(openCourseInfoModal){
                setCourseInfo(undefined);
                setOpenCourseInfoModal(prevState => !prevState)
            }
            setOpenCourseConflictModal(true);
        }
        else{
            completeAddingCourse(course_id)
        }
    }

    //Runs when a user directly clicks to add a course
    const onAddCourse = (course_id) => {
        console.log("Click to add course with ID:", course_id);
        checkIfTimingOverlap(course_id);
    }

    return (
        <div className="site-container d-flex flex-column position-relative" style={{
            height: '100vh'
        }}>
            {openCourseInfoModal && <CourseInfoModal courseInfo={courseInfo} btnInfo={[
                {
                    clickHandler: function(){
                        setCourseInfo(undefined);
                        setOpenCourseInfoModal(prevState => !prevState);
                    }, 
                    btnText: 'Close', 
                    id: 1
                }, 
                {
                    clickHandler: onAddCourse, 
                    btnText: 'Add Course', 
                    id: 2
                }
            ]}/>}
            {openCourseConflictModal && <CourseConflictModal conflictingCourses={conflictCourses} onCancel={() => {
                setConflictCourses(undefined);
                setOpenCourseConflictModal(prevState => !prevState);
            }} onReplace={(course_id) => {
                completeAddingCourse(course_id)
            }}/>}
            {showStatus && <Notification status={status} setShowStatus={setShowStatus}/> }
            <Header /> 
            <div className='site-body search-wrapper m-3 p-0 gap-2 d-flex' style={{flex: 1, minHeight: 0}}>
                <SearchSidebar /> 
                <div className='page-container col m-0 p-0 gap-1 d-flex flex-column' style={{
                    flex: 1,
                    minHeight: 0
                }}>
                    <div className='page-head sub-header d-flex flex-column gap-3'>
                        <div className='d-flex align-items-center justify-content-between'>
                            <h5 className="m-0 p-0 w-auto fw-bold text-dark">Search</h5>   
                            <Link to="/" className="text-reset m-0 p-0 w-auto d-flex gap-2" style={{
                                textDecoration: 'none'
                            }}>
                                <Button text="Schedule" icon={<BiCalendar />} color={"#EAEAEA"} />
                            </Link> 
                        </div>
                        <SearchBar setSearchQuery={setSearchQuery} searchQuery={searchQuery} onSearch={onSearch}/> 
                    </div>
                    <div className='page-body d-flex flex-column m-0 pe-3 p-0 gap-2 overflow-auto' style={{
                        flex: 1
                    }}>
                            {
                                searchResult && searchResult.length>0 && searchResult.map((result) => {
                                    return <CourseList courses={courses} result={result} key={result.id} onAddCourse={onAddCourse} handleShowCourseInfo={handleShowCourseInfo}/>
                                }) 
                            }     
                    </div>
                </div>
            </div>
        </div>
    );
  }
  
export default Search;