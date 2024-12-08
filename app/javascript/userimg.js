document.addEventListener("DOMContentLoaded", function() {
    const image = document.getElementById('image-user');
    const popup = document.getElementById('popup');
    const closeBtn = document.getElementById('close');

    if (image) {
        image.addEventListener('click', function() {
            popup.style.display = 'flex';
        });
    }

    if (closeBtn) {
        closeBtn.addEventListener('click', function() {
            popup.style.display = 'none';
        });
    }
});
