class Cache
  class << self
    def fetch_user_reactions_cache(user, post)
      Rails.cache.fetch(
        "user_#{user.id}_reactions_for_post_#{post.id}"
      )
    end

    def fetch_post_reactions_cache(post)
      Rails.cache.fetch(
        "reactions_for_post_#{post.id}"
      )
    end

    def update_user_reactions_cache(user, post)
      Rails.cache.write(
        "user_#{user.id}_reactions_for_post_#{post.id}",
        post.reactions.where(user: user)
      )
    end

    def update_post_reactions_cache(post)
      Rails.cache.write(
        "reactions_for_post_#{post.id}",
        post.reactions
      )
    end
  end
end
