module LikesHelper

  # TODO: REFACTOR!!!
  def likes_summary(post)
    return "" if post.likes.empty?

    users = post.likes.map{|like| like.user}
    count = users.count
    string = "<p>"
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
      string += " and #{link_to user.name, user_posts_path(user)} like this.</p>"
    elsif string == "<p>You"
      string += " like this."
    else
      string += " likes this."
    end

    string += "</p>"

    string.html_safe
  end
end
