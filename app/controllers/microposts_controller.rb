class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create]

    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url　#routes.rbでrootに指定しているアクションへのurlらしい
        else
            render 'static_pages/home'
        end
    end

    private
    def micropost_params
        params.require(:micropost).permit(:content)
    end
end
