import createChannel from "client/cable";

let callback;

const postId = window.location.href.split("/").slice(-1)[0];

const channelDetails = {
  channel: "PostCommentsChannel",
  post_id: postId,
};

const comments = createChannel(channelDetails, {
  received({ comment }) {
    if (callback) callback.call(null, comment);
  },
});

const sendComment = (comment) => comments.perform("send_comment", { comment });

const setCallback = (fn) => {
  callback = fn;
};

export { sendComment, setCallback };
