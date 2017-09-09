class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
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
    @comments = @post.comments
  end
  
  def view_less
    @post = Post.find(params[:id])
    best_comments = Comment.where(id: Like.where(post_id: @post.id ,target_type: "comment").group(:comment_id).order('count(comment_id) desc').limit(1).pluck(:comment_id))
		@comments = best_comments[0]
		if @comments == nil
		  @comments = @post.comments.last
		end
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.save
    @new_comment = Comment.new
    @post = @comment.post
    @comments = @post.comments.order(created_at: :desc)
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment.update(comment_params)
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :content)
    end
end
