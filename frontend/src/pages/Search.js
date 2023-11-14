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

function Search() {
    const [searchQuery, setSearchQuery] = useState('');
    const [searchResult, setSearchResult] = useState(undefined); 

    const [openCourseInfoModal, setOpenCourseInfoModal] = useState(false);
    const [courseInfo, setCourseInfo] = useState(undefined); 

    const [showStatus, setShowStatus] = useState(false); 
    const [status, setStatus] = useState(false); 


    useEffect(() => {
        //send request to get all classes for current term 
        // console.log("Request send for all classes");
        fetch('http://127.0.0.1:8080/class/info/get/1')
        .then(response => {
            if (!response.ok) {
              throw new Error('Network response was not ok');
            }
            return response.json(); 
        })
        .then(data => {
            console.log(data);
        })
        .catch(()=> {
            console.log("an error happened"); 
        })
    }, []);

    const onSearch = () => {
        //sends request to API with searchQuery, gets back result 
        console.log("Request sent for specific course"); 
        const result = [
            {
                'title': 'COEN 177', 
                'units': '4',
                'name': 'Operating Systems', 
                'co-requisites': 'COEN 177L - Operating Systems Lab', 
                'description': 'Introduction to computer operating systems. Operating system concepts, computer organization model, storage hierarchy, operating system organization, processes management, interprocess communication and synchronization, memory management and virtual memory, I/O subsystems, and file systems. Design, implementation, and performance issues.',
                'professor': 'Ahmed Amer', 
                'time': '11AM - 12:05PM', 
                'location': "O'Conner 207",
                'seats': 2, 
                'id': 1
            },
            {
                'title': 'MUSC 7', 
                'units': '4',
                'name': 'Into to Listening to Music', 
                'co-requisites': 'N/A', 
                'description': 'This course explores the relationship between music and culture as it introduces students to a wide range of musical styles throughout the world. Designed for both majors and minors, students will learn basic ethnomusicological concepts and explore musical cultures from Africa, the Americas, the Middle East, South and Southeast Asia, and Europe.',
                'professor': 'Ray Furuta', 
                'time': '8:30AM - 10:20AM', 
                'location': "Music & Dance 119",
                'seats': 10, 
                'id': 2
            }
        ];
        setSearchResult(result);
        setSearchQuery(''); 
    }

    const handleShowCourseInfo = (course_id) => {
        console.log("Course Info clicked for id:", course_id);
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
            setOpenCourseInfoModal(prevState => !prevState);
        })
    }

    const onAddCourse = (course_id) => {
        console.log("course add clicked for course:", course_id);
        //add course based on course_id to schedule
        //returns success: success
        //returns failure: unsuccessful
        setStatus(true); 
        setShowStatus(true); 
        setOpenCourseInfoModal(prevState => !prevState)
        setCourseInfo(undefined);
    }

    return (
        <div className="site-container d-flex flex-column position-relative" style={{
            height: '100vh',
            backgroundColor: "#D9FFE1"
        }}>
            {openCourseInfoModal && <CourseInfoModal courseInfo={courseInfo} btnInfo={[
                {
                    clickHandler: function(){
                        setOpenCourseInfoModal(prevState => !prevState);
                        setCourseInfo(undefined);
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
                                <Button text="View Schedule" icon={<BiCalendar />} color={"#67B0F0"} />
                            </Link> 
                        </div>
                        <SearchBar setSearchQuery={setSearchQuery} searchQuery={searchQuery} onSearch={onSearch}/> 
                    </div>
                    <div className='page-body d-flex flex-column m-0 pe-3 p-0 gap-2 overflow-auto' style={{
                        flex: 1
                    }}>
                            {
                                searchResult && searchResult.map((result) => {
                                    return <CourseList result={result} key={result.id} handleShowCourseInfo={handleShowCourseInfo}/>
                                }) 
                            }     
                    </div>
                </div>
            </div>
        </div>
    );
  }
  
export default Search;