import DeleteCourseModalCSS from './DeleteCourseModal.module.css';

function CourseConflictModal({ conflictingCourses, onCancel, onReplace} ) { 
    const labelStyle = {
        color: '#9e9d9d'
    }

    const parentClass = conflictingCourses.parent;

    return (
        <>
            <div className={`${DeleteCourseModalCSS.backdrop} h-100 w-100 position-absolute bg-dark`}></div>
            <div className={`${DeleteCourseModalCSS.wrapper} m-0 p-3 position-absolute top-50 start-50 translate-middle rounded-3 bg-dark d-flex flex-column justify-content-between`}>
                <p className="m-0 p-0 text-white"><span className="m-0 p-0 text-info fst-italic">{parentClass.title}</span> conflicts with <span className="m-0 p-0 text-info fst-italic">{conflictingCourses.conflicts.join(', ')}</span> already in your schedule. Would you like to replace the conflicting classes?</p>
                <div className="m-0 p-0 d-flex gap-2">
                    <button className={`${DeleteCourseModalCSS.modalButton} rounded border-0`} onClick={() => {onCancel()}}>Cancel</button>
                    <button className={`${DeleteCourseModalCSS.modalButton} rounded border-0 bg-danger text-white`} onClick={() => {onReplace(parentClass.id)}}>Yes, replace</button>
                </div>
            </div>
        </>
    );
  }
  
export default CourseConflictModal;