document.addEventListener('DOMContentLoaded', function() {
    const profilBtn = document.getElementById('profil-btn');
    const profilMenu = document.getElementById('profil');
    const closeBtn = document.getElementById('closeBtnProfil');
  
    profilBtn.addEventListener('click', function() {
      profilMenu.classList.toggle('show');
    });
  
    closeBtn.addEventListener('click', function() {
      profilMenu.classList.remove('show');
    });
  
    document.addEventListener('click', function(event) {
      if (!profilMenu.contains(event.target) && event.target !== profilBtn) {
        profilMenu.classList.remove('show');
      }
    });
  });
  