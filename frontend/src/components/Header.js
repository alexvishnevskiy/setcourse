function Header() {
    return (
      <div className="m-0 mx-2 p-0 py-3 px-3 d-flex justify-content-between align-items-center border-bottom" style={{flex: 0}}>
        <div className="left m-0 p-0 d-flex align-items-center">
            <img src='/sclogo.svg' alt='' style={{height:'50px', width:'50px'}}/>
            <p className="m-0 ms-2 p-0">setCourse</p>
        </div>
        <div className="right ">
            <p className="m-0 p-0">profile image</p>
        </div>
      </div>
    
    );
  }
  
export default Header;