class SearchController < ApplicationController
    
    def search 
        @search = params[:search]
        redirect_to "/search_posts/#{@search}"
    end
    
    def search_posts
        @search = params[:search]
        @posts = Post.where('content LIKE(?)', "%#{@search}%").page(params[:page]).order(id: :desc)
        
    end
    
    def search_articles
        @search = params[:search]
        @posts = Post.where('article_title LIKE(?)', "%#{@search}%").page(params[:page])

    end
    
    def search_users
        @search = params[:search]
        @users = User.where('LOWER(name) LIKE(?)', "%#{@search.downcase}%").page(params[:page])
    end
    
    def search_tags
        @search = params[:search]
        @tags = Tag.where('LOWER(name) LIKE(?)', "%#{@search.downcase}%").page(params[:page])
    end
end
