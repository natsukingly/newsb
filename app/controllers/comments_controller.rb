class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :cancel_edit_comment]
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
    @comment = current_user.comments.build(content: params[:comment][:content], post_id: params[:comment][:post_id] )
    @comment.save
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
    post_id = @comment.post_id
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(post_id), notice: 'Comment was successfully destroyed.' }
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
      params.require(:comment).permit(:post_id, :content)
    end
end
