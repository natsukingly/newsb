class PostDraftsController < ApplicationController
	before_action :set_post_draft
	
	def edit
		
	end
	
	def destroy
		@post_draft.destroy
		redirect_to drafts_users_path
	end
	
	def publish
		@new_post = current_user.posts.build(	article_id: @post_draft.article.id, 
												content: params[:post][:content],
												category_id: @post_draft.category_id,
												country_id: @post_draft.country_id,
												fake_news_report: params[:post][:fake_news_report]
												)
		if @new_post.save
			@post_draft.destroy
			flash[:notice] = "Your draft has been published."
			redirect_to article_path(@new_post.article.id)
		end
	end
	
	private
		def set_post_draft
			@post_draft = PostDraft.find(params[:id])
		end
end

