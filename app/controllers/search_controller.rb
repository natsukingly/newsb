class SearchController < ApplicationController
    before_action :set_search
    
    def search_posts
        @post_search_results = Post.where('content LIKE(?)', "%#{@search.downcase}%").order(id: :desc)
    end
    
    def search_articles
        @articles_search_results = Post.where('article_title LIKE(?)', "%#{@search.downcase}%")
    end
    
    def search_users
        @users_search_results = User.where('LOWER(name) LIKE(?)', "%#{@search.downcase}%")
    end
    
    def search_tags
        @tags_search_results = Tag.where('LOWER(name) LIKE(?)', "%#{@search.downcase}%")
    end
    
    private
        def set_search
            @search = params[:search]
        end
end
