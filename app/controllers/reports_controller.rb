
class ReportsController < ApplicationController
  before_action :authenticate
  
  def create
    if params[:report][:target_type] == "post"
      @post = Post.find(params[:report][:target_id].to_i)
      @report = @post.reports.build(content: params[:report][:content], country_id: @post.country_id, user_id: current_user.id)
      post_id = @post.id
    else
      @comment = Comment.find(params[:report][:target_id].to_i)
      @report = @comment.reports.build(content: params[:report][:content], country_id: @comment.country_id, user_id: current_user.id)  
      post_id = @comment.post_id
    end
    if @report.save
      flash[:notice] = "Thank you for submitting your report!"
      redirect_to post_path(post_id)
    else
      flash[:notice] = "Error: we couldn't process your report."
      redirect_to post_path(post_id)
    end
  end
  
end
