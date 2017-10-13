class TagsController < ApplicationController
    before_action :set_tag, except: [:index, :show_favorite]
    before_action :yes_found
    
    def show
        
    end
    
    def index
        # sort them by the number of posts in the future
        @tags = Tag.all.order(created_at: :desc)
    end
    
    def show_favorite
        @tags = current_user.favorite_tags
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
    
    
    private 
        def set_tag
            @tag = Tag.find(params[:id])
        end
        
            
end
