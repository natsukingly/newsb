class TagsController < ApplicationController
    before_action :set_tag, except: [:index, :favorite_index, :show]
    before_action :set_tag_by_name, only: [:show]
    before_action :yes_found
    before_action :set_current_topic, only: [:show]
    before_action :set_new_users
    
    def show
        
    end
    
    def index
        # sort them by the number of posts in the future
        @current_topic = t('nav.topic.tags')
        @tags = Tag.where(country_id: @country.id).order(posts_count: :desc).limit(30)
    end
    
    def favorite_index
        @current_topic = t('nav.topic.favorite')
        @tags = current_user.favorite_tags.order(created_at: :desc).limit(30)
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
        @posts = Post.all.where(category: @tag.name).order(created_at: :desc).limit(30)
    end
    
    
    private 
        def set_tag
            @tag = Tag.find_by(id: params[:id])
        end
        
        def set_tag_by_name
            @tag = Tag.find_by(name: params[:name])
        end
        
        def set_current_topic
            @current_topic = "#" + @tag.name + "・" + @tag.posts.count.to_s
        end
            
end
