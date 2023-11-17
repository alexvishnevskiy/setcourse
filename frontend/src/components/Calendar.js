import React, { useEffect } from 'react';
import { DayPilotCalendar } from "@daypilot/daypilot-lite-react";
import './Calendar.css';

const Calendar = ({ config, courses }) => {
    const determineStartPixel = (time) => {
        const date = new Date(time);
        const hour = date.getHours();
        const minutes = date.getMinutes();
        return ((90*hour)+1)+((90*minutes)/60);
    }
    
    const determineHeightInPixels = (startTime, endTime) => {
        const date1 = new Date(startTime);
        const date2 = new Date(endTime); 
        const durationInMinutes = (date2 - date1) / 1000 / 60;
        return (90*durationInMinutes)/60;
    }

    const colors = {
        1: "#D1DCDB", 
        2: "#C1A4D2", 
        3: "#E9E9E9", 
        4: "#d2c9a5", 
        5: "#c77b58"
    };  

    useEffect(() => {
        const adjustEachCourse = () => {
            if(courses.events.length <= 0) return;
            const courseList = document.querySelectorAll(".calendar_default_event");
            for(let i = 0; i < courseList.length; i++){
                const courseID = courseList[i].event.id();
                const courseObj = courses.events.find((course) => course.id === courseID);
                const start = courseObj.start.value;
                const end = courseObj.end.value;
                const startPixel = determineStartPixel(start);
                const heightInPixels = determineHeightInPixels(start, end);
                courseList[i].style.setProperty("top", `${startPixel}px`, "important");
                courseList[i].style.setProperty("height", `${heightInPixels}px`, "important");
                courseList[i].children[0].style.setProperty("background", `${colors[courseID]}`, "important");
            }
        }  
        adjustEachCourse();
    }, [config, courses]);

    return (
        <>
            <DayPilotCalendar {...config} {...courses} />
        </>
    );
}

export default Calendar;