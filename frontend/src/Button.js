function Button({ text, icon, color }) {
    return (
      <div className="m-0 px-3 py-1 d-flex align-items-center w-auto rounded-2" style={{backgroundColor: color, cursor: 'pointer'}}>
        <p className="m-0 me-1 p-0" style={{fontSize: '14px'}}>{text}</p>
        {icon}
      </div>
    );
  }
  
export default Button;