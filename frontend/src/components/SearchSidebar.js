import React from 'react'
import Select from 'react-select'
import "./Sidebar.css"

const coreReqs = [
  { value: 'advanced writing', label: 'Advanced Writing' },
  { value: 'arts', label: 'Arts' },
  { value: 'civic engagement', label: 'Civic Engagement' },
  { value: 'ctw1', label: 'CTW1' },
  { value: 'ctw2', label: 'CTW2' },
  { value: 'c&i1', label: 'Cultures & Ideas 1' },
  { value: 'c&i2', label: 'Cultures and Ideas 2' },
  { value: 'c&i3', label: 'Cultures and Ideas 3' },
  { value: 'diversity', label: 'Diversity' },
  { value: 'ethics', label: 'Ethics' },
  { value: 'elsj', label: 'Experiential Learning for Social Justics' },
  { value: 'math', label: 'Mathematics' },
  { value: 'natural science', label: 'Natural Science' },
  { value: 'rel1', label: 'Rel. 1' },
  { value: 'rel2', label: 'Rel. 2' },
  { value: 'rel3', label: 'Rel. 3' },
  { value: 'sts', label: 'Science, Technology & Society' },
  { value: 'social science', label: 'Social Science' },
]

const days = [
  { value: 'M/W/F', label: 'MWF' },
  { value: 'T/TH', label: 'TTH' },
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
                isClearable
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