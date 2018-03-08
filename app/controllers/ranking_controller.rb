class RankingController < ApplicationController
    before_action :set_new_users
    
    def user_ranking
        @current_topic = t('nav.topic.ranking')
        @users = User.order(liked_count: :desc, followers_count: :desc, created_at: :asc).limit(30)
    end
    
    def user_weekly_ranking
        @current_topic = t('nav.topic.ranking')
        @users = User.order(liked_count: :desc, followers_count: :desc, created_at: :asc).limit(30)
    end
    
end
