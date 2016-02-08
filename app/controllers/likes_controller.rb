class LikesController < ApplicationController

  def create
    # TODO: enable for generic resource type
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user_id: current_user.id)

    if @like.save
      redirect_to :back, notice: "Post liked!"
    else
      redirect_to :back, alert: "Unable to like post."
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by_user_id(current_user.id)

    if @like.destroy
      redirect_to :back, notice: "Like removed!"
    else
      redirect_to :back, alert: "Like could not be removed."
    end
  end
end
