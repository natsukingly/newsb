class TagsController < ApplicationController
    before_action :set_tag, except: [:index, :show_favorite]
    before_action :yes_found
    
    
    def index
        # sort them by the number of posts in the future
        @tags = Tag.all.where.not(name: @default_categories).where.not(name: @default_regions).order(created_at: :desc)
    end
    
    def show_favorite
        @tags = current_user.favorite_tags
    end
    
    
    def articles
        @articles = Article.where(category: @tag.name).where(published_time: 48.hours.ago..Time.now).order(created_at: :desc).limit(5)
        cookies[:search_preference] = @tag.name
        
        article_not_found
    end
    
    def articles_week
        @articles = Article.where(category: @tag.name).where(published_time: 168.hours.ago..Time.now).order(created_at: :desc).limit(5)
        cookies[:search_preference] = @tag.name
        
        article_not_found
    end
    
    def articles_month
        @articles = Article.where(category: @tag.name).where(published_time: 720.hours.ago..Time.now).order(created_at: :desc).limit(5)
        cookies[:search_preference] = @tag.name
        
        article_not_found
    end
    
    def favorite
        favorite = current_user.favorites.build(tag_id: @tag.id) 
        favorite.save
    end
    
    def unfavorite
        favorite = Favorite.find_by(tag_id: @tag.id, user_id: current_user.id)
        favorite.destroy
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
    
    def articles_not_found
        
    end
    
    
    private 
        def set_tag
            @tag = Tag.find(params[:id])
        end
        
        def article_not_found
            if @articles.empty?
                @not_found = true
            end
        end
            
end
