import React, { useState, useEffect } from 'react';
import { DayPilotCalendar } from "@daypilot/daypilot-lite-react";
import '../Calendar.css';

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


const Calendar = () => {
    const [colors, setColors] = useState({
        1: "#D1DCDB", 
        2: "#C1A4D2", 
        3: "#E9E9E9", 
        4: "#d2c9a5", 
        5: "#c77b58"
    }); 

    const adjustEachCourse = (events) => {
        const courseList = document.querySelectorAll(".calendar_default_event");
        for(let i = 0; i < courseList.length; i++){
            const courseID = courseList[i].event.id();
            const courseObj = events.find((course) => course.id === courseID);
            const start = courseObj.start.value;
            const end = courseObj.end.value;
            const startPixel = determineStartPixel(start);
            const heightInPixels = determineHeightInPixels(start, end);
            courseList[i].style.setProperty("top", `${startPixel}px`, "important");
            courseList[i].style.setProperty("height", `${heightInPixels}px`, "important");
            courseList[i].children[0].style.setProperty("background", `${colors[courseID]}`, "important");
        }
    }

    const [courses, setCourses] = useState({
        events: [
            {
                "resource": "MON",
                "start": "2023-11-02T14:15:00",
                "end": "2023-11-02T15:20:00",
                "text": "COEN 177\n2:15-3:20", 
                "id": 1, 
            },
            {
                "resource": "TUE",
                "start": "2023-11-02T16:15:00",
                "end": "2023-11-02T17:23:00",
                "text": "MUSC 7\n4:15-5:23", 
                "id": 2, 
            },
            {
                "resource": "WED",
                "start": "2023-11-02T14:15:00",
                "end": "2023-11-02T15:20:00",
                "text": "COEN 177\n2:15-3:20", 
                "id": 1, 
            },
            {
                "resource": "FRI",
                "start": "2023-11-02T14:15:00",
                "end": "2023-11-02T15:20:00",
                "text": "COEN 177\n2:15-3:20", 
                "id": 1, 
            },
            {
                "resource": "THU",
                "start": "2023-11-02T16:15:00",
                "end": "2023-11-02T17:23:00",
                "text": "MUSC 7\n4:15-5:23", 
                "id": 2, 
            },
        ]
    });

    const config = {
        viewType: "Resources",
        startDate: "2023-11-02", 
        columns: [
            {name: "mon", id: "MON"},  
            {name: "tue", id: "TUE"},  
            {name: "wed", id: "WED"},  
            {name: "thu", id: "THU"},  
            {name: "fri", id: "FRI"},  
            {name: "sat", id: "SAT"},  
            {name: "sun", id: "SUN"},  
        ],  
        timeRangeSelectedHandling: "Disabled",
        eventMoveHandling: "Disabled",
        eventResizeHandling: "Disabled",
        eventClickHandling: "Disabled",
        eventHoverHandling: "Disabled",
        cellHeight: 45, //dont change this value
        durationBarVisible: false, 
        useEventBoxes: "ShortEventsOnly",
        eventDeleteHandling: "Callback",
        onEventDeleted: (args) => {
            const id = args.e.data.id;
            const newEvents = courses.events.filter((event) => event.id !== id);
            setCourses({events: newEvents});
        },
    };

    useEffect(() => {
        adjustEachCourse(courses.events);
    }, [config]);

    return (
        <>
            <DayPilotCalendar {...config} {...courses} />
        </>
    );
}

export default Calendar;