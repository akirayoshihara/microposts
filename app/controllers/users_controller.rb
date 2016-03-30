class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update, :destroy]  #show見せないようにする
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.follower_users
    render 'show_follow'
  end
  
  def index
    @users = User.all
  end

  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render 'edit'
    end
  end
  
#  def search　 #self
#      if Page.exists?　 #self
#        render 'user_path'　 #self
#      else　 #self
#  　     @user = User.find(params[:id])　 #self
#        render 'notfound'　 #self
#      end　 #self
#  end　 #self
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :age, :comment,
                                 :password_confirmation)
  end
  
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id]) 
    redirect_to root_url if @user != current_user
  end
end