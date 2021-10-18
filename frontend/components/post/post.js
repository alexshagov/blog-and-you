import "./post.pcss";

import { setCallback } from "client/post-ws-actions";
import { initializeEventListeners } from "../post-comment-reactions/post-comment-reactions";

const comments = document.getElementsByClassName(".js-post--comments")[0];

setCallback((comment) => {
  comments.innerHTML += comment;
  window.scrollTo(0, document.body.scrollHeight);
  initializeEventListeners();
});
