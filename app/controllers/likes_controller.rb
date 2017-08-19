class LikesController < ApplicationController
    def post_like
    	@post = Post.find(params[:post_id])
    	like = Like.new(user_id: current_user.id, post_id: @post.id, comment_id: "", reply_id: "", target_type: "post") 
    	like.save
    end
    
    def post_unlike
        @post = Post.find(params[:post_id])
        like = Like.find_by(user_id: current_user.id, post_id: @post.id, target_type: "post")
        like.destroy
    end
    
    def comment_like
    	@comment = Comment.find(params[:comment_id])
    	like = Like.new(user_id: current_user.id, comment_id: @comment.id, post_id: "", reply_id: "", target_type: "comment") 
    	like.save
    end
    
    def comment_unlike
        @comment = Comment.find(params[:comment_id])
        like = Like.find_by(user_id: current_user.id, comment_id: @comment.id, target_type: "comment")
        like.destroy
    end
    
    def reply_like
    	@reply = Reply.find(params[:reply_id])
    	like = Like.new(user_id: current_user.id, reply_id: @reply.id, post_id: "", comment_id: "",target_type: "reply") 
    	like.save
    end
    
    def reply_unlike
        @reply = Reply.find(params[:reply_id])
        like = Like.find_by(user_id: current_user.id, reply_id: @reply.id, target_type: "reply")
        like.destroy
    end

end
