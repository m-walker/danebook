class NewsfeedController < ApplicationController
  before_action :require_login

  def newsfeed
    @posts = current_user.newsfeed_items
    @user = current_user
    @post = Post.new
    @comment = Comment.new
  end
end
