module LikesHelper

  def likes_summary(post)
    likes = post.likes
    string = ""

    if likes.count > 2
      string = "<p>#{link_to likes.first.user.name, user_posts_path(likes.first.user)}, #{link_to likes.second.user.name, user_posts_path(likes.second.user)}, and #{likes.count - 2} others like this.</p>"
    elsif likes.count == 2
      string = "<p>#{link_to likes.first.user.name, user_posts_path(likes.first.user)} and #{link_to likes.second.user.name, user_posts_path(likes.second.user)} like this.</p>"
    elsif likes.count == 1
      string = "<p>#{link_to likes.first.user.name, user_posts_path(likes.first.user)} likes this.</p>"
    end

    string.html_safe
  end
end
