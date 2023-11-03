import Button from '../Button';
import Calendar from './Calendar';
import Header from './Header'; 
import Sidebar from './Sidebar'; 
import { BiEdit, BiPlus } from 'react-icons/bi';
import React, { useState, useEffect } from 'react';

function Home() {
    return (
      <div className="vh-100 d-flex flex-column">
        <Header /> 
        <div className="m-3 p-0 d-flex row gap-2" style={{flex: 1}}> 
            <Sidebar /> 
            <div className="main col d-flex flex-column">
                <div className="d-flex justify-content-between align-items-center mb-3">
                    <h5 className="m-0 p-0 w-auto fw-bold text-dark">Schedule</h5>
                    <div className="m-0 p-0 w-auto d-flex gap-2">
                        {/* <Button text="Edit Schedule" icon={<BiEdit />} color={"#EAEAEA"} /> */}
                        <Button text="Add Course" icon={<BiPlus />} color={"#EAEAEA"} />
                    </div>
                </div>
                <div className="calendar m-0 p-0" style={{flex: 1}}>
                    <Calendar />
                </div>
            </div>
        </div>
      </div>
    );
  }
  
export default Home;