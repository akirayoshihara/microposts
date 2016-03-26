class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    
    def index
    end
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "コメント投稿完了!"
            redirect_to root_url
        else
            render 'static_pages/home'
        end
    end
    
    def destroy
    @micropost = current_user.microposts.find_by(id: params[:id] )
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "削除されました"
    redirect_to request.referrer|| root_url
    end

    private
    def micropost_params
        params.require(:micropost).permit(:content)
    end
end