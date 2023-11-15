import DeleteCourseModalCSS from './DeleteCourseModal.module.css';

function CourseInfoModal({ courseInfo, btnInfo} ) { 
    console.log('course info:', courseInfo); 
    const labelStyle = {
        color: '#9e9d9d'
    }
    return (
        <>
            <div className={`${DeleteCourseModalCSS.backdrop} h-100 w-100 position-absolute bg-dark`}></div>
            <div style={{height: '400px', width: '700px'}} className={`${DeleteCourseModalCSS.wrapper} m-0 p-3 position-absolute top-50 start-50 translate-middle rounded-3 bg-dark d-flex flex-column justify-content-between`}>
                <div className="info-wrapper text-white overflow-auto" style={{'fontSize': '15px'}}>
                    <div className='row m-0 mb-3 p-0'>
                        <p className="col-3 m-0 p-0" style={labelStyle}>Title</p>
                        <p className="col m-0 p-0">{ courseInfo.title} - { courseInfo.name}</p>
                    </div>
                    <div className='row m-0 mb-3 p-0'>
                        <p className="col-3 m-0 p-0" style={labelStyle}>Units</p>
                        <p className="col m-0 p-0">{ courseInfo.units}</p>
                    </div>
                    <div className='row m-0 mb-3 p-0'>
                        <p className="col-3 m-0 p-0" style={labelStyle}>Co-requisites</p>
                        <p className="col m-0 p-0">{ courseInfo['co-requisites']}</p>
                    </div>
                    <div className='row m-0 mb-3 p-0'>
                        <p className="col-3 m-0 p-0" style={labelStyle}>Description</p>
                        <p className="col m-0 p-0">{ courseInfo.description}</p>
                    </div>
                    <div className='row m-0 mb-3 p-0'>
                        <p className="col-3 m-0 p-0" style={labelStyle}>Professor</p>
                        <p className="col m-0 p-0">{ courseInfo.professor}</p>
                    </div>
                    <div className='row m-0 mb-3 p-0'>
                        <p className="col-3 m-0 p-0" style={labelStyle}>Time</p>
                        <p className="col m-0 p-0">{ courseInfo.start} - {courseInfo.end}</p>
                    </div>
                    <div className='row m-0 mb-3 p-0'>
                        <p className="col-3 m-0 p-0" style={labelStyle}>Location</p>
                        <p className="col m-0 p-0">{ courseInfo.location}</p>
                    </div>
                </div>
                <div className="m-0 p-0 d-flex gap-2">
                {
                    btnInfo.map((info) => {
                        return <button key={info.id} className={`${DeleteCourseModalCSS.modalButton} rounded border-0`} style={{
                            background: info.backColor
                        }} onClick={() => {info.clickHandler(courseInfo['class_id'])}}>{info.btnText}</button>
                    })
                }
                </div>
            </div>
        </>
    );
  }
  
export default CourseInfoModal;