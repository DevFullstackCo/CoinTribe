document.addEventListener('turbo:load', () => {
  const postsContainer = document.querySelector('#posts_container');

  if (postsContainer) {
    postsContainer.addEventListener('click', (e) => {
      const post = e.target.closest('.post');

      if (post) {
        const commentLine = post.querySelector('.comment-line');
        const newCommentInput = post.querySelector('.new-comment');

        if (commentLine) {
          if (newCommentInput && newCommentInput.contains(e.target)) {
            return;
          }


          commentLine.classList.toggle('visible');
          commentLine.classList.toggle('hidden');

          if (commentLine.classList.contains('visible')) {
            post.classList.add('shadow');
          } else {
            post.classList.remove('shadow');
          }
        }
      }
    });
  }
});


document.addEventListener('turbo:frame-load', () => {
  const postsContainer = document.querySelector('#posts_container');

  if (postsContainer) {
    postsContainer.addEventListener('click', (e) => {
      const post = e.target.closest('.post');

      if (post) {
        const commentLine = post.querySelector('.comment-line');
        const newCommentInput = post.querySelector('.new-comment');

        if (commentLine) {
          if (newCommentInput && newCommentInput.contains(e.target)) {
            return;
          }

          commentLine.classList.toggle('visible');
          commentLine.classList.toggle('hidden');

          if (commentLine.classList.contains('visible')) {
            post.classList.add('shadow');
          } else {
            post.classList.remove('shadow');
          }
        }
      }
    });
  }
});

document.addEventListener('turbo:load', function () {
  const contentField = document.getElementById('content-field');
  const sendButton = document.getElementById('send-button');

  contentField.addEventListener('input', function () {
    if (contentField.value.trim() !== '') {
      sendButton.style.display = 'block';
    } else {
      sendButton.style.display = 'none';
    }
  });
});
