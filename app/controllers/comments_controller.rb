class CommentsController < ApplicationController
  before_action :set_resource, only: [:create]

  def create
    @comment = @resource.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :back, notice: "Comment successfully saved!"
    else
      redirect_to :back, alert: "Comment could not be saved."
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])

    if @comment.destroy
      redirect_to :back, notice: "Comment deleted!"
    else
      redirect_to :back, alert: "Comment could not be deleted."
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

  def comment_params
    params.require(:comment).permit(:content)
  end
end
