class SearchController < ApplicationController
    before_action :set_key_word
    
    def search
        redirect_to "/search/#{@key_word}/articles"
    end
    
    def posts
        @posts_search_results = Post.where('LOWER(content) LIKE(?)', "%#{@key_word.downcase}%").order(likes_count: :desc)
    end
    
    def articles
        @articles_search_results = Article.where('LOWER(title) LIKE(?)', "%#{@key_word.downcase}%").order(likes_count: :desc)
    end
    
    def users
        @users_search_results = User.where('LOWER(name) LIKE(?)', "%#{@key_word.downcase}%")
    end
    
    def tags
        @tags_search_results = Tag.where('LOWER(name) LIKE(?)', "%#{@key_word.downcase}%")
    end
    
    private
        def set_key_word
            @key_word = params[:key_word]
        end
end
