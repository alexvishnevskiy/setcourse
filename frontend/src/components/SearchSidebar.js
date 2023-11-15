import React from 'react'
import Select from 'react-select'
import "./Sidebar.css"

const coreReqs = [
  { value: 'art', label: 'Art' },
  { value: 'natural science', label: 'Natural Science' },
  { value: 'religion 1', label: 'Religion 1' }
]

const days = [
  { value: 'monday', label: 'Monday' },
  { value: 'tuesday', label: 'Tuesday' },
  { value: 'wednesday', label: 'Wednesday' },
  { value: 'thursday', label: 'Thursday' },
  { value: 'friday', label: 'Friday' },
  { value: 'saturday', label: 'Saturday' },
  { value: 'sunday', label: 'Sunday' },
]

function SearchSidebar({setCoreReqs, setDays}) {
    return (
        <div className="sidebar m-0 p-2 col-2 rounded-2">
          <p className="m-0 mt-1 mb-2 p-0 fw-bold text-light">Filters</p>
          <div className='d-flex flex-column gap-2'>
            <div>
              <p className="m-0 mt-1 mb-1 p-0 fw-bold input-label">Core Requirements</p>
              <Select
                isMulti
                name="colors"
                options={coreReqs}
                className="basic-multi-select"
                classNamePrefix="select"
                onChange={(val) => {
                  setCoreReqs(val)
                }}
              />
            </div>
            <div>
              <p className="m-0 mt-1 mb-1 p-0 fw-bold input-label">Day</p>
              <Select
                isMulti
                name="colors"
                options={days}
                className="basic-multi-select"
                classNamePrefix="select"
                onChange={(val) => {
                  setDays(val)
                }}
              />
            </div>
          </div>
        </div>
    );
  }
  
export default SearchSidebar;