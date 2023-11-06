import React, { useState } from 'react';

const SearchPage = ({ onSearch }) => {
  const [searchQuery, setSearchQuery] = useState('');

  const handleSearch = () => {
    // Perform search logic based on searchQuery (e.g., fetch data from API)
    // For example purposes, let's assume you have a list of available courses:
    const availableCourses = [
      { id: 1, name: 'COEN 177' },
      { id: 2, name: 'MUSC 7' },
      // Add more courses as needed
    ];

    // Filter courses based on the search query
    const filteredCourses = availableCourses.filter(course =>
      course.name.toLowerCase().includes(searchQuery.toLowerCase())
    );

    // Pass the filtered courses back to the parent component
    onSearch(filteredCourses);
  };

  return (
    <div>
      <input
        type="text"
        placeholder="Search for courses..."
        value={searchQuery}
        onChange={(e) => setSearchQuery(e.target.value)}
      />
      <button onClick={handleSearch}>Search</button>
    </div>
  );
};

export default SearchPage;
