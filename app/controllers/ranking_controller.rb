class RankingController < ApplicationController
    before_action :set_new_users
    
    def user_ranking
        @current_topic = "Ranking"
        @users = User.where(country_id: @country.id).order(liked_count: :desc).limit(30)
    end
    
    def user_weekly_ranking
        @current_topic = "Ranking"
        @users = User.where(country_id: @country.id).order(weekly_liked_count: :desc).limit(30)
    end
    
end
