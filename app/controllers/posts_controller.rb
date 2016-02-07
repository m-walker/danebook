class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @posts = @user.posts.order(:created_at => :desc)
  end
end
