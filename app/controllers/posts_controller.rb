class PostsController < ApplicationController
  before_action :require_login, except: [:index]

  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @posts = @user.posts.includes(:likes => [:user], :comments => [:user]).order(:created_at => :desc)
    @post = @user.posts.build if @user == current_user
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(current_user), notice: "Posted!"
    else
      redirect_to user_posts_path(current_user), alert: "Could not save post."
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    if @post.destroy
      redirect_to user_posts_path(current_user), notice: "Post successfully deleted!"
    else
      redirect_to user_posts_path(current_user), alert: "Could not delete post."
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
