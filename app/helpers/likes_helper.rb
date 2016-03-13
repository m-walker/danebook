module LikesHelper

  # TODO: REFACTOR!!!
  def likes_summary(resource)
    return "" if resource.likes.empty?

    users = resource.likes.map{|like| like.user}
    # TODO: ...map(&:user)
    count = users.count
    string = ""
    current_user_index = users.index{|user| user[:id] == current_user.id}

    if current_user_index
      users.delete_at(current_user_index)
      string += "You"
    else
      user = users.pop
      string += "#{link_to user.name, user_posts_path(user)}"
    end

    user = users.pop

    if count > 3
      string += ", #{link_to user.name, user_posts_path(user)}, and #{count - 2} others like this."
    elsif count == 3
      string += " and #{link_to user.name, user_posts_path(user)} like this."
    elsif string == "You"
      string += " like this."
    else
      string += " likes this."
    end

    string.html_safe
  end

  def like_link(resource)
    # TODO: refactor - maybe change up routes
    if resource.is_a? Post
      path = post_like_path(resource)
    elsif resource.is_a? Comment
      path = comment_like_path(resource)
    else
      path = photo_like_path(resource)
    end

    if resource.liked_by?(current_user.id)
      string = "#{link_to fa_icon('thumbs-up', text: 'Unlike'), path, method: :delete, class: 'post-action'}"
    else
      string = "#{link_to fa_icon('thumbs-up', text: 'Like'), path, method: :post, class: 'post-action'}"
    end

    string.html_safe
  end
end
