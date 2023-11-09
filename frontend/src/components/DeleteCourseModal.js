import '../DeleteCourseModal.css';

function DeleteCourseModal({setOpenDeleteModal, onConfirmDelete, itemToDelete}) {
    return (
        <>
            <div className='backdrop h-100 w-100 position-absolute bg-dark'></div>
            <div className="wrapper m-0 p-3 position-absolute top-50 start-50 translate-middle rounded-3 bg-dark d-flex flex-column justify-content-between">
                <p className="m-0 p-0 text-white">Are you sure you want to delete <span className="m-0 p-0 text-info fst-italic">{itemToDelete.title}</span> from your schedule?</p>
                <div className="m-0 p-0 d-flex gap-2">
                    <button className="rounded border-0" onClick={() => {setOpenDeleteModal(prevState => !prevState)}}>Cancel</button>
                    <button className="rounded border-0 bg-danger text-white" onClick={() => {onConfirmDelete()}}>Yes, delete</button>
                </div>
            </div>
        </>
    );
  }
  
export default DeleteCourseModal;