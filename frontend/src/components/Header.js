import { Link } from 'react-router-dom'; 

function Header() {
    return (
      <div className="m-0 mx-2 p-0 py-3 px-3 d-flex justify-content-between align-items-center border-bottom" style={{flex: 0}}>
        <Link to="/" className="left m-0 p-0 d-flex align-items-center text-reset" style={{
                        textDecoration: 'none'
                    }}>
            <img src='/sclogo.svg' alt='' style={{height:'25px', width:'25px'}}/>
            <p className="m-0 ms-2 p-0">setCourse</p>
        </Link>
        <Link to="/login" className="left m-0 p-0 d-flex align-items-center text-reset" style={{
                        textDecoration: 'none'
                    }}>
          <div className="right ">
              <p className="m-0 p-0">profile image</p>
          </div>
        </Link>
      </div>
    
    );
  }
  
export default Header;