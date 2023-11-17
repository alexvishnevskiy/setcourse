import { AiFillQuestionCircle } from 'react-icons/ai';
import { FaCheckCircle } from "react-icons/fa";
import { FaPlusCircle } from "react-icons/fa";
import { FaQuestionCircle } from "react-icons/fa";
import CourseListCSS from './CourseList.module.css';

const checkIfTimingOverlap = (startTime, endTime, courses, result) => {
      for(let i = 0; i < courses.events.length; i++){
        if(courses.events[i].id === result.id){
          return <FaCheckCircle size={20} style={{color: 'gray'}}/> 
        }
        const startInterval = new Date(courses.events[i].start).getTime();
        const endInterval = new Date(courses.events[i].end).getTime();
        const targetStart = startTime.getTime(); 
        const targetEnd = endTime.getTime(); 

        if(startInterval <= targetEnd && targetEnd <= endInterval || targetStart <= endInterval && endInterval <= targetEnd){
          const currentClassDays = result.days.split("/");
          const currentSearchResultClassDays = courses.events[i].resource.split("/");
          if(currentClassDays.some(item => currentSearchResultClassDays.includes(item))){
            return <FaQuestionCircle size={20} style={{color: '#dc3545'}}/> 
          }
        }
      }
      return <FaPlusCircle size={20} style={{color: '#67AB5B'}}/>;
}

function CourseList({ courses, result, handleShowCourseInfo, onAddCourse }) {
    function formatTimeString(dateTimeString) {
      const options = { hour: 'numeric', minute: 'numeric' };
      const formattedTime = new Date(dateTimeString).toLocaleTimeString([], options);
      return formattedTime;
    } 
    return (
      <div className={`${CourseListCSS.wrapper} m-0 py-3 px-3 rounded-3 d-flex justify-content-between align-items-center`} onClick={() => {handleShowCourseInfo(result.id)}} style={{
        fontSize: '15px', 
        cursor: 'pointer',
      }}>
        <div className="d-flex flex-column gap-1">
            <p className="m-0 p-0">{result.title} - {result.name}</p>
            <div className="d-flex align-items-center gap-3">
                <p className="m-0 p-0">{result.days}</p>
                <p className="m-0 p-0">{formatTimeString(`2023-11-02${result.start}`)} - {formatTimeString(`2023-11-02${result.end}`)}</p>
                <p className="m-0 p-0 text-success">{result.seats} Seats Open</p>
            </div>
        </div>
        <div className="d-flex align-items-center gap-3">
            <p className="m-0 p-0">{result.professor}</p>
            <div className="m-0 p-1 rounded-1 d-flex justify-content-center align-items-center" style={{cursor: 'pointer'}} onClick={(e) => {
              e.preventDefault(); 
              e.stopPropagation();
              onAddCourse(result.id)
            }}>
              {checkIfTimingOverlap(new Date("2023-11-02" + result.start), new Date("2023-11-02" + result.end), courses, result)}
            </div>
        </div>
      </div>
    );
  }
  
export default CourseList;