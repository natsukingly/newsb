class RankingController < ApplicationController
    before_action :set_new_users
    
    def user_ranking
        @current_topic = "Ranking"
        @users = User.order(liked_count: :desc).limit(100)
    end
    
    def user_weekly_ranking
        @current_topic = "Ranking"
        @users = User.order(weekly_liked_count: :desc).limit(100)
    end
    
end
