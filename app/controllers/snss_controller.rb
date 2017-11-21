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
    
    def share_twitter
        @user.twitter_post = true
        @user.save
    end
    def unshare_twitter
        @user.twitter_post = false
        @user.save
    end
    
    def share_linkedin
        @user.linkedin_post = true
        @user.save
    end
    def unshare_linkedin
        @user.linkedin_post = false
        @user.save
    end
    
    private
        def set_user
            @user = User.find(params[:id])
        end
end
