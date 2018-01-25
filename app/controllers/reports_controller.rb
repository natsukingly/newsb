
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
      flash[:notice] = t('flash.report.success')
      redirect_to post_path(post_id)
    else
      flash[:notice] = t('flash.general_error')
      redirect_to post_path(post_id)
    end
  end
  
end
