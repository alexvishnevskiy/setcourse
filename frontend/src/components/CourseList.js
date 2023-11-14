import { FcPlus } from 'react-icons/fc';
import { AiFillQuestionCircle } from 'react-icons/ai';

const checkIfTimingOverlap = (startTime, endTime, courses) => {
      for(let i = 0; i < courses.events.length; i++){
        const startInterval = new Date(courses.events[i].start).getTime();
        const endInterval = new Date(courses.events[i].end).getTime();
        const targetStart = startTime.getTime(); 
        const targetEnd = endTime.getTime(); 
        if(startInterval <= targetEnd && targetEnd <= endInterval || targetStart <= endInterval && endInterval <= targetEnd){
          return <AiFillQuestionCircle size={20} style={{color: '#dc3545'}}/> 
        }
      }
      return <FcPlus size={20} />;
}

function CourseList({ courses, result, handleShowCourseInfo, onAddCourse }) {
  console.log('courses', courses)
    return (
      <div className="m-0 py-3 px-3 rounded-3 d-flex justify-content-between align-items-center" onClick={() => {handleShowCourseInfo(result.id)}} style={{
        fontSize: '15px', 
        background: 'rgb(234,234,234)'
      }}>
        <div className="d-flex flex-column gap-1">
            <p className="m-0 p-0">{result.title} - {result.name}</p>
            <div className="d-flex align-items-center gap-3">
                <p className="m-0 p-0">{result.start} - {result.end}</p>
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
              {checkIfTimingOverlap(new Date("2023-11-02" + result.start), new Date("2023-11-02" + result.end), courses)}
            </div>
        </div>
      </div>
    );
  }
  
export default CourseList;