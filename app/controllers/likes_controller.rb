class LikesController < ApplicationController
    before_action :set_post, only: [:post_like, :post_unlike]
    before_action :set_comment, only: [:comment_like, :comment_unlike]
    before_action :set_reply, only: [:reply_like, :reply_unlike]
    
    # before_action :set_attribute
    
    # def like
    #     if params[:post_id]
    #         @post = Post.find(params[:post_id])
    #         like = @post.likes.build(user_id: current_user.id)
            
    #     elsif params[:comment_id]
    #         @comment = Comment.find(params[:comment_id])
    #         like = @comment.likes.build(user_id: current_user.id)
    #     else
    #         @reply = Reply.find(params[:reply_id])
    #         like = @reply.likes.build(user_id: current_user.id)
    #     end
        
    #     like.save
    # end
    
    # def unlike
    #     if params[:post_id]
    #         @post = Post.find(params[:post_id])
    #         like = @post.likes.find_by(user_id: current_user.id)
            
    #     elsif params[:comment_id]
    #         @comment = Comment.find(params[:comment_id])
    #         like = @comment.likes.find_by(user_id: current_user.id)
            
    #     else
    #         @reply = Reply.find(params[:reply_id])
    #         like = @reply.likes.find_by(user_id: current_user.id)
            
    #     end
        
    #     like.destroy
    # end
    
    
    
    
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
    
    def reply_like
        like = @reply.likes.build(user_id: current_user.id)
    	like.save
    end
    
    def reply_unlike
        like = @reply.likes.find_by(user_id: current_user.id)
        like.destroy
    end

    private
        def set_post
            @post = Post.find(params[:post_id])
        end        
        
        def set_comment
            @comment = Comment.find(params[:comment_id])
        end

        def set_reply
            @reply = Reply.find(params[:reply_id])
        end
        
        # def set_attribute
        #     if params[:post_id]
        #         @post = Post.find(params[:post_id])
        #     elsif params[:comment_id]
        #         @comment = Comment.find(params[:comment_id])
        #     else
        #         @reply = Reply.find(params[:reply_id])
        #     end
        # end
            
end
