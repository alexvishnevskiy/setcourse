function CourseList({ result, handleShowCourseInfo }) {
    return (
      <div className="m-0 py-3 px-3 rounded-3 d-flex justify-content-between align-items-center" style={{
        fontSize: '15px', 
        background: 'rgb(234,234,234)'
      }}>
        <div className="d-flex flex-column gap-1">
            <p className="m-0 p-0">{result.title} - {result.name}</p>
            <div className="d-flex align-items-center gap-3">
                <p className="m-0 p-0">{result.time}</p>
                <p className="m-0 p-0 text-success">{result.seats} Seats Open</p>
            </div>
        </div>
        <div className="d-flex align-items-center gap-3">
            <p className="m-0 p-0">{result.professor}</p>
            <p className="m-0 p-0" onClick={() => {handleShowCourseInfo(result.id)}}>Button</p>
        </div>
      </div>
    );
  }
  
export default CourseList;