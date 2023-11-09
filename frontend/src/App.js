import { BrowserRouter, Routes, Route } from 'react-router-dom'; 
import Login from './pages/Login';
import Home from './pages/Home';
import Search from './pages/Search';
import React, { useState } from 'react';

function App() {
  const [courses, setCourses] = useState({
    events: []
  });

  const [scheduleID, setScheduleID] = useState(undefined);

  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route index element={<Home courses={courses} setCourses={setCourses}/>} />
          <Route path='/search' element={<Search />} />
          <Route path='/login' element={<Login />} />
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default App;
