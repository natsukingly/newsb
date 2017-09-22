class RelationshipsController < ApplicationController
    
    def follow
        @user = User.find(params[:id])
        relationship = Relationship.new(follower_id: current_user.id, following_id: @user.id)
        relationship.save
    end

    def unfollow
        @user = User.find(params[:id])
        relationship =  Relationship.find_by(follower_id: current_user.id, following_id: @user.id)
        relationship.destroy
    end
end
