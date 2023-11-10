import '../Sidebar.css';

function Sidebar({ courses, getCourseInfo }) {
    const getUniqueCourses = () => {
        let countedCoursesID = []; 
        let countedCourses = []; 
        courses.forEach((course) => {
            if(!countedCoursesID.includes(course.id)){
                countedCoursesID.push(course.id); 
                countedCourses.push(course); 
            }
        });
        return countedCourses; 
    }
    return (
        <div className="sidebar m-0 p-2 col-2 rounded-2">
            <p className="m-0 mt-1 mb-3 p-0 fw-bold text-light">Schedule Info</p>
            <div className="accordion" id="accordionFlushExample">
                <div className="accordion-item">
                    <h2 className="accordion-header" id="flush-headingOne">
                    <button className="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                        Your courses
                    </button>
                    </h2>
                    <div id="flush-collapseOne" className="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                        <div className="accordion-body">
                            <ul className='mb-0 p-0 list-unstyled'>
                                {getUniqueCourses().map((course) => {
                                    return <li style={{cursor: 'pointer'}} className='text-white' key={course.id} onClick={() => {getCourseInfo(course.id)}}>{course.title}</li>
                                })}
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
  }
  
export default Sidebar;