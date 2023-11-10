import '../SearchBar.css'; 

function SearchBar({setSearchQuery, searchQuery, onSearch}) {
    return (
        <div className="row m-0 mb-2 aling-items-center p-0 gap-2">
            <input
                type="text"
                placeholder="e.g. CSCI 187"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="border-1 m-0 px-2 rounded-2"
                onKeyDown={(e) => {
                    if (e.key === 'Enter') {
                        onSearch();
                    }
                }}
            />
            <button onClick={() => onSearch()} className="border-0 rounded-2">Search</button>
        </div>
    );
  }
  
export default SearchBar;