class CommentsController < ApplicationController
	before_action :set_comment, only: [:show, :edit, :cancel_edit_comment]
	before_action :set_comment_from_form, only: [:update, :destroy]
	before_action -> { authenticate_user(@comment, post_path(@comment.post_id)) }, only: [:update, :destroy]
	before_action :authenticate, only: [:create, :create_report]
	# GET /comments
	# GET /comments.json
	def index
		@comments = Comment.all
	end

	# GET /comments/1
	# GET /comments/1.json
	def show
	end
	
	def view_more
		@post = Post.find(params[:id])
	end
	
	def view_less
		@post = Post.find(params[:id])
	end

	# GET /comments/new
	def new
		@post = Post.find(params[:id])
		@comment = Comment.new
	end

	# GET /comments/1/edit
	def edit
	end
	
	def cancel_edit_comment
	end

	# POST /comments
	# POST /comments.json
	def create
		@post = Post.find(params[:comment][:post_id])
		
		@comment = current_user.comments.build(content: params[:comment][:content], post_id: @post.id, article_id: @post.article_id )
		@comment.save
		redirect_to post_path(@comment.post_id)
	end

	# PATCH/PUT /comments/1
	# PATCH/PUT /comments/1.json
	def update
		@comment.update(content: params[:comment][:content])
		redirect_to post_path(@comment.post_id)
	end

	# DELETE /comments/1
	# DELETE /comments/1.json
	def destroy
		post_id = @comment.post_id
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to post_path(post_id), notice: 'Comment was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	def create_report
		@report = @comment.reports.build(	user_id: current_user.id, 
										content: params[:report][:content])
		@report.save
	end


	private
		# Use callbacks to share common setup or constraints between actions.
		def set_comment
			@comment = Comment.find(params[:id])
		end
		
		def set_comment_from_form
			@comment = Comment.find(params[:comment][:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def comment_params
			params.require(:comment).permit(:post_id, :content)
		end
end
