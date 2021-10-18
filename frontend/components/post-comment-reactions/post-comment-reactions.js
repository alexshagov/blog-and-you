import "./post-comment-reactions.pcss";

import {
  addReaction,
  retractReaction,
  setCallback,
} from "client/post-reactions-ws-actions";

const initializeEventListeners = function () {
  document
    .querySelectorAll(".js-post--comment-reactions ul li")
    .forEach((item) => {
      item.addEventListener("click", () => {
        if (item.classList.contains("js-reaction-sent")) {
          retractReaction(item.dataset.reactionType, item.dataset.commentId);
          item.classList.remove("js-reaction-sent");
        } else {
          addReaction(item.dataset.reactionType, item.dataset.commentId);
          item.classList.add("js-reaction-sent");
        }
      });
    });
};

setCallback((reactionType, commentId, value) => {
  const reaction = document.querySelectorAll(
    `li.${reactionType}[data-comment-id="${commentId}"]`
  )[0];
  reaction.innerHTML = parseInt(reaction.innerHTML, 10) + value;
});

initializeEventListeners();

// eslint-disable-next-line import/prefer-default-export
export { initializeEventListeners };
