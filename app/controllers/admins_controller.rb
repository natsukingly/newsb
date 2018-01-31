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
	
	def unchecked_reports
		@reports = Report.all.where(check: false).includes(:user, :country, :reportable).order(created_at: :desc).limit(20)
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
	
	def newsb_notifications_index
		@newsb_notifications = Notification.where(everyone: true).order(created_at: :desc).offset(@existing_notifications).limit(30)
	end
	
	def create_newsb_notification
		
		title = params[:notification][:title]
		content = params[:notification][:message]
		message = "<span class='notification_title'>#{title}</span>#{content}"
		language_id = Language.find_by(code: params[:notification][:language_code]).id
		country_id = Country.find_by(name: params[:notification][:country_name]).id
		path = params[:notification][:path]
		unless path.nil?
			link = true
		end
		# notification = Notification.new(user_id: 1, message: "aaaa", notification_type: "public", everyone: true, country_id: 6, language_id: 6)  
		@notification = Notification.new(user_id: current_user.id,
										everyone: true,
										path: path,
										link: link,
										message: message,
										notification_type: "public",
										country_id: country_id,
										language_id: language_id)
		if @notification.save
			flash[:notice] = "successfully notified everyone!"
			redirect_to newsb_notifications_index_admins_path
		else
			flash[:alert] = "ERROR: couldn't issue notification"
			redirect_to newsb_notifications_index_admins_path			
		end
	end
	
	def delete_newsb_notification
		newsb_notification = Notification.find(params[:id])
		if newsb_notification.destroy
			flash[:notice] = "deleted the newsb public notification"
			redirect_to newsb_notifications_index_admins_path
		else
			flash[:alert] = "failed"
			redirect_to newsb_notifications_index_admins_path
		end
		
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
