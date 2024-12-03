document.addEventListener('DOMContentLoaded', function() {
    const btn1dMain = document.getElementById('btn-1d-main');
    const timeOptions = document.getElementById('time-options');
    const timeLabel = document.getElementById('time-label');
    
    timeOptions.style.display = 'none';
  
    btn1dMain.addEventListener('click', function(event) {
      event.stopPropagation();
      timeOptions.style.display = timeOptions.style.display === 'none' ? 'block' : 'none';
    });
  
    document.getElementById('btn-6h').addEventListener('click', function() {
      timeLabel.textContent = '6h';
    });

    document.getElementById('btn-12h').addEventListener('click', function() {
        timeLabel.textContent = '12h';
      });
  
    document.getElementById('btn-1d').addEventListener('click', function() {
      timeLabel.textContent = '1d';
    });
  
    document.addEventListener('click', function(event) {
      if (!timeOptions.contains(event.target) && event.target !== btn1dMain) {
        timeOptions.style.display = 'none';
      }
    });
});
