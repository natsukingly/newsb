class LikesController < ApplicationController
    def post_like
    	@post = Post.find(params[:post_id])
    	like = LikePost.new(user_id: current_user.id, 
                            post_id: @post.id, 
                            article_id: @post.article_id)
    	like.save
    end
    
    def post_unlike
        @post = Post.find(params[:post_id])
        like = LikePost.find_by(user_id: current_user.id, post_id: @post.id)
        like.destroy
    end
    
    def comment_like
    	@comment = Comment.find(params[:comment_id])
    	
    	like = LikeComment.new(user_id: current_user.id, 
                    	comment_id: @comment.id)
    	like.save
    end
    
    def comment_unlike
        @comment = Comment.find(params[:comment_id])
        like = LikeComment.find_by(user_id: current_user.id, comment_id: @comment.id)
        like.destroy
    end
    
    def reply_like
    	@reply = Reply.find(params[:reply_id])
    	like = LikeReply.new(user_id: current_user.id, 
                    	    reply_id: @reply.id)
    	like.save
    end
    
    def reply_unlike
        @reply = Reply.find(params[:reply_id])
        like = LikeReply.find_by(user_id: current_user.id, reply_id: @reply.id)
        like.destroy
    end

end
