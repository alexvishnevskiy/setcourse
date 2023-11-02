import Calendar from './Calendar';
import Header from './Header'; 

function Home() {
    return (
      <div className="vh-100 d-flex flex-column">
        {/* <Header />  */}
        <Calendar />
      </div>
    );
  }
  
export default Home;