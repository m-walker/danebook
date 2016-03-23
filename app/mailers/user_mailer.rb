class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to the OlympusBook!")
  end

  def comment_notification(resource, comment)
    @resource = resource
    @user = @resource.user
    @comment = comment

    mail(to: @user.email, subject: "#{@comment.user.name} commented on your #{@comment.commentable_type}")
  end
end
