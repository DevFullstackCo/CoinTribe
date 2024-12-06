if (!localStorage.getItem('pageReloaded')) {
    localStorage.setItem('pageReloaded', 'true');
    window.location.reload();
  } else {
    localStorage.removeItem('pageReloaded');
  }