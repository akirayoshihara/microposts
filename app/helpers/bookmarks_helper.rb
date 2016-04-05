module BookmarksHelper
    def bookmark_icon(micropost,user)
        if user
            if user.bookmarks.exists?(post: micropost)
                '<i class="fa fa-bookmark fa-2x"></i>'
            else
                '<i class="fa fa-bookmark fa-bookmark-o fa-2x"></i>'
            end
        end
    end
end