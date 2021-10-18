import createChannel from "client/cable";

let callback;

const postId = window.location.href.split("/").slice(-1)[0];

const reactionsChannelDetails = {
  channel: "PostCommentsReactionsChannel",
  post_id: postId,
};

const reactions = createChannel(reactionsChannelDetails, {
  received({ reactionType, commentId, value }) {
    if (callback) callback.call(null, reactionType, commentId, value);
  },
});

const addReaction = (reactionType, commentId) =>
  reactions.perform("add_reaction", { reactionType, commentId });
const retractReaction = (reactionType, commentId) =>
  reactions.perform("retract_reaction", { reactionType, commentId });

const setCallback = (fn) => {
  callback = fn;
};

export { addReaction, retractReaction, setCallback };
