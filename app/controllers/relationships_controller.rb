class RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow.destroy(params[:user_id])
    redirect_to request.referer
  end

  def followings
  end

  def followers
  end
end
