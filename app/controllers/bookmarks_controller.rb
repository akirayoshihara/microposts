class BookmarksController < ApplicationController
    belongs_to :user
    belongs_to :micropost
    
    def toggle
        micropost_id = params[:micropost_id]
        user_bookmarks = current_user.bookmarks
        if user_bookmarks.exists?(post: micropost_id)
            user_bookmarks.save
            user_bookmarks.where(post: micropost_id).destroy_all
        else
            user_bookmarks.create(user: current_user, post: Micropost.find(micropost_id))
        end
        render :nothing => true
    end
end