function Login() {
    return (
      <div className="d-flex vh-100 m-0 p-0" style={{backgroundColor: "#FFE7E8"}}>
        <div className="left bg-danger rounded-4 m-2 p-2 d-flex flex-column" style={{flex: 1, 'background-image': 'url("/scu-main.jpeg")', 'background-size': 'cover', 'background-position': 'center', 'opacity': '.8', border:"2px solid black"}}></div>
        <div className="right m-2 p-0 d-flex flex-column" style={{flex: 1}}>
          <div className="header m-0 mt-2 p-0 px-2 d-flex justify-content-between align-items-center">
            <p className="m-0 p-0 fw-bold fs-5 text-black">setCourse</p>
            {/* <p className="m-0 p-0 text-white">logo</p> */}
            <img src='/sclogo.svg' alt='' style={{height:'50px', width:'50px'}}/>
          </div>
          <div className="wrapper d-flex flex-column justify-content-center align-items-center" style={{flex: 1}}>
            <div className="welcome m-0 mb-5 p-0 d-flex flex-column justify-content-center align-items-center">
              <h2 className="m-0 p-0 text-black">Welcome!</h2>
              <p className="m-0 p-0 text-black" style={{'font-size': '14px'}}>Login with your SCU email address</p>
            </div>
            <div className="m-0 p-0 text-black">Continue with google</div>
          </div>
        </div>
      </div>
    );
  }
  
  export default Login;