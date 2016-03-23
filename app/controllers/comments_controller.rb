class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_resource, only: [:create]

  def show
    comment = Comment.find(params[:id])
    @resource = get_original_resource(comment)
    @user = @resource.user
    redirect_to url_for([@user, @resource])
  end

  def create
    @comment = @resource.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      unless @comment.user == @resource.user
        Comment.send_notification(@resource.id, @comment.id)
      end
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

  def get_original_resource(comment)
    if comment.commentable_type == 'Post'
      Post.find(comment.commentable_id)
    elsif comment.commentable_type == 'Photo'
      Photo.find(comment.commentable_id)
    else
      comment = Comment.find(comment.commentable_id)
      get_original_resource(comment)
    end
  end

  def set_resource
    if params[:comment_id]
      @resource = Comment.find(params[:comment_id])
    elsif params[:post_id]
      @resource = Post.find(params[:post_id])
    else
      @resource = Photo.find(params[:photo_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
