class BookmarksController < ApplicationController
    before_action :logged_in_user
    
    def index
    end
    
    def show
        @micropost = Micropost.find(params[:micropost_id])
        @microposts = @user.bookmark_microposts.order(created_at: :desc)
    end
    def create
        @micropost = Micropost.find(params[:micropost_id])
        current_user.bookmark(@micropost)
    end
    def destroy
        @micropost = current_user.bookmarks_relationships.find(params[:id])
        current_user.unbookmark(@micropost)
    end
    
end