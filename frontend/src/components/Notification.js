function Notification({status, setShowStatus}) {
    if(status.currentStatus === null) {
        return;
    }
    const handleSetStatus = () => {
        setShowStatus((prevState) => !prevState)
    }
    const success = <div style={{width: '400px'}} className="alert alert-success alert-dismissible fade show position-absolute top-0 start-50 translate-middle-x mt-3" role="alert">
        <strong>{status.message}</strong>
        <button type="button" className="btn-close" data-bs-dismiss="alert" aria-label="Close" onClick={handleSetStatus}></button>
    </div>

    const failure = <div style={{width: '400px'}} className="alert alert-danger alert-dismissible fade show position-absolute top-0 start-50 translate-middle-x mt-3" role="alert">
        <strong>{status.message}</strong>
        <button type="button" className="btn-close" data-bs-dismiss="alert" aria-label="Close" onClick={handleSetStatus}></button>
    </div>
    return status.currentStatus ? success : failure; 
  }
  
export default Notification;