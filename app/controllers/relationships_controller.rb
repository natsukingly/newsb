class RelationshipsController < ApplicationController
    
    def follow
        @user = User.find(params[:following_id])
        relationship = Relationship.new(follower_id: current_user.id, following_id: params[:following_id])
        relationship.save
    end

    def unfollow
        @user = User.find(params[:following_id])
        relationship =  Relationship.find_by(follower_id: current_user.id, following_id: params[:following_id])
        relationship.destroy
    end
end
