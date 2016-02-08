class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :back, notice: "Comment successfully saved!"
    else
      redirect_to :back, alert: "Comment could not be saved."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
