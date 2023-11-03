import React, { useState } from 'react';
import { DayPilotCalendar } from "@daypilot/daypilot-lite-react";

const Calendar = () => {
    const [config, setConfig] = useState({
        viewType: "Resources",
        startDate: "2023-11-02", 
        columns: [
            {name: "MON", id: "R1"},  
            {name: "TUE", id: "R2"},  
            {name: "WED", id: "R3"},  
            {name: "THU", id: "R4"},  
            {name: "FRI", id: "R5"},  
            {name: "SAT", id: "R6"},  
            {name: "SUN", id: "R7"},  
        ], 
        events: [
            {
              "resource": "R1",
              "start": "2023-11-02T11:00:00",
              "end": "2023-11-02T12:00:00",
              "text": "Class\ntoday", 
              "id": 1
            },
            {
                "resource": "R2",
                "start": "2023-11-02T11:00:00",
                "end": "2023-11-02T12:00:00",
                "text": "Class\ntoday", 
                "id": 2
            },
        ], 
        eventMoveHandling: "Disabled",
        eventResizeHandling: "Disabled",
        eventClickHandling: "Disabled", 
    });

    return (
        <div>
            <DayPilotCalendar {...config}/>
        </div>
    );
}

export default Calendar;