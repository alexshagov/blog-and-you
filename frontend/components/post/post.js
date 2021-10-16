import "./post.pcss";

import { setCallback } from "client/post-comments";

const comments = document.getElementsByClassName(".js-post--comments")[0];

setCallback((comment) => {
  comments.innerHTML += comment;
  window.scrollTo(0, document.body.scrollHeight);
});
