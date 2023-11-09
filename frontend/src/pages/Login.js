function Login() {
    return (
      <div className="d-flex vh-100 m-0 p-0 bg-dark">
        <div className="left bg-danger rounded-4 m-2 p-2 d-flex flex-column" style={{flex: 1, 'background-image': 'url("/scu-main.jpeg")', 'background-size': 'cover', 'background-position': 'center', 'opacity': '.8'}}></div>
        <div className="right m-2 p-0 d-flex flex-column" style={{flex: 1}}>
          <div className="header m-0 mt-2 p-0 px-2 d-flex justify-content-between align-items-center">
            <p className="m-0 p-0 text-white">setCourse</p>
            <p className="m-0 p-0 text-white">logo</p>
          </div>
          <div className="wrapper d-flex flex-column justify-content-center align-items-center" style={{flex: 1}}>
            <div className="welcome m-0 mb-5 p-0 d-flex flex-column justify-content-center align-items-center">
              <h2 className="m-0 p-0 text-white">Welcome!</h2>
              <p className="m-0 p-0 text-white" style={{'font-size': '14px'}}>Login with your SCU email address</p>
            </div>
            <div className="m-0 p-0 text-white">Continue with google</div>
          </div>
        </div>
      </div>
    );
  }
  
  export default Login;