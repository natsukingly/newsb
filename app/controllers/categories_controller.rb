class CategoriesController < ApplicationController
    before_action :set_category
    before_action :set_current_topic_for_all, only: [:top, :all_posts]
    # before_action :save_selected_topic, only: [:articles]
    
    def all_posts
        if @country.id == 1
            @posts = Post.order(created_at: :desc)
        else
            @posts = Post.where(country_id: @country.id).order(created_at: :desc) 
        end
    end
    
    def show
        
    end
    
    def top
        if @country.id == 1
            @articles = Article.order(likes_count: :desc).limit(10)
        else
            @articles = Article.where(country_id: @country.id).order(likes_count: :desc).limit(10)
        end
    end
    
    def articles
        if @country.id == 1
            @articles = @category.articles.order(likes_count: :desc).limit(10)
        else 
            @articles = @category.articles.where(country_id: @country.id).order(likes_count: :desc).limit(10)
        end
    end
    
    def posts
       @posts = @category.posts.includes(:user, :article).order(created_at: :desc)
    end
    
    def load_more
        existing_articles = params[:existing_articles]
        @articles = Article.all.order(likes_count: :desc).limit(5)
    end
    
    
    private 
        
        def article_not_found
            if @articles.empty?
                @not_found = true
            end
        end
        
        def save_selected_topic
            session[:selected_topic] = @category.id
        end
        
        def set_category
            if params[:id]
                @category = Category.find(params[:id])
            end
        end
        
        def set_current_topic_for_all
            @all_topic = "all"
        end
end
