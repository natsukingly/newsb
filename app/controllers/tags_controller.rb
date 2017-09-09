class TagsController < ApplicationController
    before_action :set_tag
    
    def articles
        @articles = Article.all.where(category: @tag.name).where(published_time: 48.hours.ago..Time.now).order(created_at: :desc).limit(5)
        cookies[:search_preference] = @tag.name
    end
    
    def articles_week
        @articles = Article.all.where(category: @tag.name).where(published_time: 168.hours.ago..Time.now).order(created_at: :desc).limit(5)
        cookies[:search_preference] = @tag.name
    end
    
    def articles_month
        @articles = Article.all.where(category: @tag.name).where(published_time: 720.hours.ago..Time.now).order(created_at: :desc).limit(5)
        cookies[:search_preference] = @tag.name
    end
    
    
    
    def posts
        @posts = Post.all.where(category: @tag.name).order(created_at: :desc).limit(5)
    end
    
    
    def users
    end
    
    def users_week
    end
    
    def users_month
    end
    
    
    
    private 
        def set_tag
            @tag = Tag.find(params[:id])
        end
end
