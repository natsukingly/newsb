class CategoriesController < ApplicationController
    before_action :set_category
    before_action :save_selected_topic, only: [:articles]
    
    def all_posts
        @posts = Post.order(created_at: :desc)
    end
    
    def show
        
    end
    
    def top
        @articles = Article.order(likes_count: :desc).limit(5)
    end
    
    def articles
        # @articles = Article.sortByLikes(Like.recent.limit(2).popularArticles(@category.articles.ids))
        @articles = @category.articles.order(likes_count: :desc).limit(5)
    end
    
    def posts
       @posts = @category.posts.includes(:user, :article).order(created_at: :desc)
    end
    
    def load_more
        existing_articles = params[:existing_articles]
        # @articles = Article.sortByLikes(Like.recent.offset(existing_articles).limit(2).popularArticles(@category.articles.ids))
        @articles = Article.all.order(likes_count: :desc).limit(5)
    end
    
    
    private 
        def set_category
            if params[:id]
                @category = Category.find(params[:id])
            else 
                @category = Category.find(session[:selected_topic])
            end
        end
        
        def article_not_found
            if @articles.empty?
                @not_found = true
            end
        end
        
        def save_selected_topic
            session[:selected_topic] = @category.id
        end
end
