class AdminsController < ApplicationController
	before_action :authenticate_admin
	before_action :set_admin, only: []
	
	def drafts
		@post_drafts = current_user.post_drafts.where(hide: false).includes(:article).limit(30)
	end
	
	def publish_draft
		@post_draft = PostDraft.find(params[:id])
		@fake_news_report = params[:post_draft][:fake_news_report].nil? ? false : true
		@new_post = current_user.posts.build(	article_id: @post_draft.article.id, 
												content: params[:post_draft][:content],
												category_id: params[:post_draft][:category_id].to_i,
												country_id: @post_draft.country_id,
												fake_news_report: @fake_news_report,
												)
		if @new_post.save
			@post_draft.destroy
		else
			render 'admins/drafts'
		end
	end
	
	def hide_draft
		@post_draft = PostDraft.find(params[:id])
		@post_draft.hide = "true"
		@post_draft.save
	end
	
	def reports
		@reports = Report.all.includes(:user, :country, :reportable).order(created_at: :desc).limit(20)
		@reports_count = @reports.count
		@non_checked_reports_count = @reports.where(check: false).count
	end

	def check_report
		@report = Report.find(params[:id])
		@report.check = true
		@report.save
	end
	
	def uncheck_report
		@report = Report.find(params[:id])
		@report.check = false
		@report.save
	end
	
	
	private
		def authenticate_admin
			if current_user.admin != true
				flash[:notice] = "You are not authorized to access this page"
				redirect_to root_path
			end
		end
		
		def set_admin
			@admin = User.find(params[:id])
		end
end
