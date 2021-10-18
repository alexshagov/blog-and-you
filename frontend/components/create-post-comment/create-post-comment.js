import "./create-post-comment.pcss";

import { sendComment } from "client/post-ws-actions";

const isMac = navigator.platform.match(/Mac/) != null;

const handleLineBreak = (input) => {
  // eslint-disable-next-line no-param-reassign
  input.value = `${input.value}\n`;
};

const handleSubmit = (input) => {
  const { value } = input;

  if (value.length === 0) {
    return;
  }

  sendComment(input.value);
  // eslint-disable-next-line no-param-reassign
  input.value = "";
  input.focus();
};

const form = document.querySelector(".js-post--comment-form");

if (form) {
  const input = form.querySelector(".js-input");
  const submit = form.querySelector(".js-submit");

  input.addEventListener("keydown", (event) => {
    if (event.code !== "Enter") {
      return;
    }

    event.preventDefault();

    const { altKey, ctrlKey, metaKey, shiftKey } = event;
    const withModifier = altKey || shiftKey || (isMac ? ctrlKey : metaKey);

    if (withModifier) {
      handleLineBreak(input);
    } else {
      handleSubmit(input);
    }
  });

  submit.addEventListener("click", (event) => {
    event.preventDefault();
    handleSubmit(input);
  });
}
