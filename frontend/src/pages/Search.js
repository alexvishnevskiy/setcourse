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

function Search({courses, setCourses, scheduleID}) {
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
    const [status, setStatus] = useState({
        currentStatus: false, 
        message: 'An error occured'
    }); 

    //Holds information about the filters the user has selected
    const [coreReqs, setCoreReqs] = useState([]);
    const [days, setDays] = useState(null);

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
        .then(() => {
            //send request to get all classes for current term, place in search result state 
            fetch('http://127.0.0.1:8080/class/all/get')
            .then(response => {
                if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                let classes = []; 
                for(let classData of data){
                    const specificClass = {
                        'title': classData.title, 
                        'units': classData.units, 
                        'name': classData.name,
                        'start': `T${classData.start}:00`, 
                        'end': `T${classData.end}:00`, 
                        'seats': classData.seats,
                        'professor': classData.professor,
                        'days': classData.days,
                        'id': classData.class_id, 
                    } 
                    classes.push(specificClass); 
                }
                setSearchResult(classes)
            })
        })
        .catch(error => {
            console.error('Fetch error:', error);
        });
    }, []);

    //Runs when user clicks search. 
    const onSearch = () => {
        //sends request to API with searchQuery, gets back result 
        // /class/all/get?search_query=<>&core_req=<>&days=<>
        const coreReqsArr = [];
        for(let filter of coreReqs){
            coreReqsArr.push(encodeURIComponent(filter.value));
        }

        const daysArr = (days === null || days === undefined) ? [] : [encodeURIComponent(days.value)] ;

        const createQueryString = (search_query, core_req, days_filter) => {
            let start = "/class/all/get"; 
            let count = 0; 
            if(search_query !== undefined){
                count++; 
                start += "?"+search_query; 
            }
            if(core_req !== undefined){
                if(count > 0){
                    start += `&core_req=${coreReqsArr.join('&core_req=')}`;
                }
                else{
                    start += '?' + `core_req=${coreReqsArr.join('&core_req=')}`
                    count++;
                }
            }
            if(days_filter !== undefined){
                if(count > 0){
                    start += `&days=${daysArr.join('&days=')}`;
                }
                else{
                    start += '?' + `days=${daysArr.join('&days=')}`
                    count++;
                }
            }
            return start; 
        }

        const search_query = searchQuery.trim().length > 0 ? `search_query=${encodeURIComponent(searchQuery.trim())}` : undefined; 
        const core_req = coreReqsArr.length > 0 ? coreReqsArr : undefined; 
        const days_filter = daysArr.length > 0 ? daysArr : undefined; 

        const url = createQueryString(search_query, core_req, days_filter)

        fetch('http://127.0.0.1:8080'+url)
        .then((response) => {
            if(response.ok){
                return response.json()
            }
            throw new Error("failed to get classes"); 
        })
        .then((fetchedClasses) => {
            if(fetchedClasses.length > 0){
                let classes = []; 
                for(let classData of fetchedClasses){
                    const specificClass = {
                        'title': classData.title, 
                        'units': classData.units, 
                        'name': classData.name,
                        'start': `T${classData.start}:00`, 
                        'end': `T${classData.end}:00`, 
                        'seats': classData.seats,
                        'professor': classData.professor,
                        'days': classData.days,
                        'id': classData.class_id, 
                    } 
                    classes.push(specificClass); 
                }
                setSearchResult(classes);
                setSearchQuery(''); 
            }
            else{
                setSearchResult(undefined);
                setSearchQuery(''); 
            }
        })
        .catch((err) => {
            setSearchResult(undefined);
            setSearchQuery(''); 
        })
    }

    //Runs when a user clicks on a class listing to view info
    const handleShowCourseInfo = (course_id) => {
        fetch(`http://127.0.0.1:8080/class/info/get/${course_id}`)
        .then(response => {
            if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json();
        })
        .then((data) => {
            setCourseInfo(data);
            setOpenCourseInfoModal(prevState => !prevState);
        })
        .catch(error => {
            console.error('Fetch error:', error);
        });
    }

    //Runs after verifying class repalcement or simply adding a course
    const completeAddingCourse = (course_id) => {
        //add course using API endpoint
        fetch(`http://127.0.0.1:8080/courses/add/${scheduleID}/${course_id}`, {
            method: 'POST',
        })
        .then(response => {
            console.log('response:', response)
            if (response.ok) {
                return response.json();
            } else {
                return response.json().then(errorData => {
                    throw new Error(errorData.message);
                })
            }
        })
        .then((data) => {
            fetch(`http://127.0.0.1:8080/class/info/get/${course_id}`)
            .then(response => {
                if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
                }
                return response.json();
            })
            .then((fetchedClass) => {
                setCourses((prevState) => {
                    const startTime = formatTimeString(`2023-11-02T${fetchedClass.start}:00`);
                    const endTime = formatTimeString(`2023-11-02T${fetchedClass.end}:00`); 
                    return { events: [...prevState.events, {
                        'resource': fetchedClass.days,
                        'start': `2023-11-02T${fetchedClass.start}:00`,
                        'end': `2023-11-02T${fetchedClass.end}:00`,
                        'text': `${fetchedClass.title}\n${startTime}-${endTime}`,
                        'title': fetchedClass.title,
                        'id': fetchedClass.class_id
                    }]}
                })
                setStatus({
                    currentStatus: true,
                    message: data.message
                }); 
            })
        })
        .catch(error => {
            setStatus({
                currentStatus: false,
                message: error.message
            }); 
        });
        setShowStatus(true); 
        setCourseInfo(undefined);
        openCourseInfoModal && setOpenCourseInfoModal(prevState => !prevState); 
        setConflictCourses(undefined); 
        openCourseConflictModal && setOpenCourseConflictModal(prevState => !prevState); 
    }

    //Checks to see if the class the user wants to add conflicts with a class already in their schedule
    const checkIfTimingOverlap = (course_id) => {
        //get the course
        fetch(`http://127.0.0.1:8080/class/info/get/${course_id}`)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json();
        })
        .then((fetchedClass) => {
            //check time conflict (which classes it conflicts with)
            console.log('fetched class', fetchedClass)
            let classConflicts = []; 
            for(let i = 0; i < courses.events.length; i++){
                const startInterval = new Date(courses.events[i].start).getTime();
                const endInterval = new Date(courses.events[i].end).getTime();
                const targetStart = new Date("2023-11-02T" + fetchedClass.start + ":00").getTime();
                const targetEnd = new Date("2023-11-02T" + fetchedClass.end + ":00").getTime();
                if(startInterval <= targetEnd && targetEnd <= endInterval || targetStart <= endInterval && endInterval <= targetEnd){
                    const currentClassDays = fetchedClass.days.split("/");
                    const currentSearchResultClassDays = courses.events[i].resource.split("/");
                    if(currentClassDays.some(item => currentSearchResultClassDays.includes(item))){
                        classConflicts.push(courses.events[i].title);
                    }
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
        })

    }

    //Runs when a user directly clicks to add a course
    const onAddCourse = (course_id) => {
        //check if its already in the schedule (then do nothing)
        for(let i = 0; i < courses.events.length; i++){
            if(courses.events[i].id === course_id){
                return;
            }
        }
        checkIfTimingOverlap(course_id);
    }

    return (
        <div className="site-container d-flex flex-column position-relative" style={{
            height: '100vh',
            backgroundColor: "#D9FFE1",
            backgroundImage: "url('/searchBackground.png')", 
            backgroundPosition: "right bottom", 
            backgroundRepeat: "no-repeat"
        }}>
            {openCourseInfoModal && <CourseInfoModal courseInfo={courseInfo} btnInfo={[
                {
                    clickHandler: function(){
                        setCourseInfo(undefined);
                        setOpenCourseInfoModal(prevState => !prevState);
                    }, 
                    btnText: 'Close', 
                    backColor: '',
                    id: 1
                }, 
                {
                    clickHandler: onAddCourse, 
                    btnText: 'Add Course', 
                    backColor: '#44DB56',
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
                <SearchSidebar setCoreReqs={setCoreReqs} setDays={setDays}/> 
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
                                <Button text="View Schedule" icon={<BiCalendar />} color={"#67B0F0"} />
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