class RankingController < ApplicationController

    def user_ranking
        @current_topic = "Ranking"
        @users = User.order(liked_count: :desc).limit(100)
    end
    
    def user_weekly_ranking
        @current_topic = "Ranking"
        @users = User.order(weekly_liked_count: :desc).limit(100)
    end
    
end
