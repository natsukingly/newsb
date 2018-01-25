class SearchController < ApplicationController
    before_action :set_keyword
    before_action :set_current_topic
    before_action :set_new_users
    
    def search
        redirect_to search_articles_path(@keyword)
    end
    
    def posts
        @posts_search_results = Post.where(country_id: @country.id).where('LOWER(content) LIKE(?)', "%#{@keyword.downcase}%").order(likes_count: :desc).limit(30)
    end
    
    def articles
        @articles_search_results = Article.where(country_id: @country.id).where('LOWER(title) LIKE(?)', "%#{@keyword.downcase}%").order(e_indecator: :desc, published_time: :desc).limit(30)
    end
    
    def users
        @users_search_results = User.where(country_id: @country.id).where('LOWER(name) LIKE(?)', "%#{@keyword.downcase}%").limit(30)
    end
    
    def tags
        @tags_search_results = Tag.where(country_id: @country.id).where('LOWER(name) LIKE(?)', "%#{@keyword.downcase}%").order(posts_count: :desc).limit(30)
    end
    
    private
        def set_keyword
            @keyword = params[:keyword]
        end
        
        def set_current_topic
            @current_topic = I18n.t('search.result') + " " + @keyword 
        end
end
