function LoadingSpinner() {
    return (
        <div class="d-flex justify-content-center align-items-center h-100">
            <div class="spinner-border" style={{
                width: '5rem',
                height: '5rem'
            }} role="status">
                <span class="sr-only"></span>
            </div>
        </div>
    );
  }
  
export default LoadingSpinner;