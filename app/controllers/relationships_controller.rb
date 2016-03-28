class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index  #m
    @relationships = Relationships.find(params[:follower_id]) #m
  end #m
  
  def index #m
    @relationships = Relationships.find(params[:followed_id]) #m
  end #m
  

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end

  def destroy
    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end