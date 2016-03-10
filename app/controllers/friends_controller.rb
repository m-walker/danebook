class FriendsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
  end

  def create
    accepter = User.find(params[:accepter_id])
    friendship = Friend.new(requester: current_user, accepter: accepter)

    if friendship.save
      redirect_to accepter.profile, notice: "You're now friends with #{accepter.name}"
    else
      redirect_to :back, alert: "Cound not add friendship."
    end
  end

  def destroy
    current_friend = User.find(params[:current_friend])
    friendship = Friend.find_friendship(current_user, current_friend)

    if friendship.destroy
      redirect_to :back, notice: "Successfully unfriended #{current_friend.name}"
    else
      redirect_to :back, alert: "Cound not remove friendship."
    end
  end
end
