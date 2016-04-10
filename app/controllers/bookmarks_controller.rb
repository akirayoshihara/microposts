class BookmarksController < ApplicationController
    before_action :logged_in_user
    
    def create
        @micropost = Micropost.find(params[:micropost_id])
        current_user.bookmark(@micropost)
    end
    def destroy
        @micropost = current_user.bookmarks_relationships.find(params[:id]).micropost
        current_user.unbookmark(@micropost)
    end
    
end