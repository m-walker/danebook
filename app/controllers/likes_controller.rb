class LikesController < ApplicationController
  before_action :set_resource

  def create
    @like = @resource.likes.build(user_id: current_user.id)

    if @like.save
      redirect_to :back, notice: "#{@resource.class} liked!"
    else
      redirect_to :back, alert: "Unable to like #{@resource.class}."
    end
  end

  def destroy
    @like = @resource.likes.find_by_user_id(current_user.id)

    if @like.destroy
      redirect_to :back, notice: "Like removed!"
    else
      redirect_to :back, alert: "Like could not be removed."
    end
  end

  private

  def set_resource
    if params[:comment_id]
      @resource = Comment.find(params[:comment_id])
    else
      @resource = Post.find(params[:post_id])
    end
  end
end
