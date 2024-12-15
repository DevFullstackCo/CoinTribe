document.addEventListener('turbo:load', function () {
  initProfileMenu();
});

document.addEventListener('turbo:render', function () {
  initProfileMenu();
});

function initProfileMenu() {
  const profilBtn = document.getElementById('profil-btn');
  const profilMenu = document.getElementById('profil');
  const closeBtn = document.getElementById('closeBtnProfil');

  if (profilBtn && profilMenu && closeBtn) {
    profilBtn.removeEventListener('click', handleProfileBtnClick);
    closeBtn.removeEventListener('click', handleCloseBtnClick);
    document.removeEventListener('click', handleDocumentClick);

    profilBtn.addEventListener('click', handleProfileBtnClick);
    closeBtn.addEventListener('click', handleCloseBtnClick);
    document.addEventListener('click', handleDocumentClick);
  }
}

function handleProfileBtnClick() {
  const profilMenu = document.getElementById('profil');
  profilMenu.classList.toggle('show');
}

function handleCloseBtnClick() {
  const profilMenu = document.getElementById('profil');
  profilMenu.classList.remove('show');
}

function handleDocumentClick(event) {
  const profilMenu = document.getElementById('profil');
  const profilBtn = document.getElementById('profil-btn');

  if (!profilMenu.contains(event.target) && event.target !== profilBtn) {
    profilMenu.classList.remove('show');
  }
}

