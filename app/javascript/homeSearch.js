document.addEventListener("click", (event) => {
  const searchInput = document.getElementById("search-input-home");
  const searchResults = document.getElementById("search-results");

  if (searchInput.contains(event.target)) {
    searchResults.style.display = "block";
  } else if (!searchResults.contains(event.target)) {
    searchResults.style.display = "none";
  }
});
