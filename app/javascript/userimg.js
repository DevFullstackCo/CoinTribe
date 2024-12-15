document.addEventListener("turbo:load", function () {
    const image = document.getElementById('image-user');
    const popup = document.getElementById('popup');
    const closeBtn = document.getElementById('close');

    if (image) {
        image.addEventListener('click', function () {
            popup.style.display = 'flex';
        });
    }

    if (closeBtn) {
        closeBtn.addEventListener('click', function () {
            popup.style.display = 'none';
        });
    }
});

document.addEventListener("turbo:load", function () {
    const editIcon = document.getElementById('open-username-popup');
    const usernamePopup = document.getElementById('username-popup');
    const closeUsernamePopupBtn = document.getElementById('close-username-popup');

    if (editIcon) {
        editIcon.addEventListener('click', function () {
            usernamePopup.style.display = 'flex';
        });
    }

    if (closeUsernamePopupBtn) {
        closeUsernamePopupBtn.addEventListener('click', function () {
            usernamePopup.style.display = 'none';
        });
    }
});

