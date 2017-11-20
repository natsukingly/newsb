class SnssController < ApplicationController
    before_action :set_user
    
    def share_facebook
        @user.facebook_post = true
        @user.save
    end
    def unshare_facebook
        @user.facebook_post = false
        @user.save
    end
    private
        def set_user
            @user = User.find(params[:id])
        end
end
