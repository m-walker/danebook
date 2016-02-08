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

  end
end
