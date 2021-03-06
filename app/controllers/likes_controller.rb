class LikesController < ApplicationController
    before_action :set_post, only: [:post_like, :post_unlike]
    before_action :set_comment, only: [:comment_like, :comment_unlike]
    before_action :authenticate
    
    def post_like
    	like = @post.likes.build(user_id: current_user.id)
    	like.save
    end
    
    def post_unlike
        like = @post.likes.find_by(user_id: current_user.id)
        like.destroy
    end
    
    def comment_like
        like = @comment.likes.build(user_id: current_user.id)
    	like.save
    end
    
    def comment_unlike
        like = @comment.likes.find_by(user_id: current_user.id)
        like.destroy
    end
 

    private
        def set_post
            @post = Post.find(params[:post_id])
        end        
        
        def set_comment
            @comment = Comment.find(params[:comment_id])
        end

end
