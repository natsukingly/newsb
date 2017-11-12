class SearchController < ApplicationController
    before_action :set_keyword
    before_action :set_current_topic
    before_action :set_new_users
    
    def search
        redirect_to "/search/#{@keyword}/articles"
    end
    
    def posts
        @posts_search_results = Post.where('LOWER(content) LIKE(?)', "%#{@keyword.downcase}%").order(likes_count: :desc)
    end
    
    def articles
        @articles_search_results = Article.where('LOWER(title) LIKE(?)', "%#{@keyword.downcase}%").order(likes_count: :desc)
    end
    
    def users
        @users_search_results = User.where('LOWER(name) LIKE(?)', "%#{@keyword.downcase}%")
    end
    
    def tags
        @tags_search_results = Tag.where('LOWER(name) LIKE(?)', "%#{@keyword.downcase}%")
    end
    
    private
        def set_keyword
            @keyword = params[:keyword]
        end
        
        def set_current_topic
            @current_topic = "Search Results"
        end
end
