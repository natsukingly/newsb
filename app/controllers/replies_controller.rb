class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all
  end

  # GET /replies/1
  # GET /replies/1.json 
  def show
  end
  
  def view_more
    @comment = Comment.find(params[:id])
    @replies = @comment.replies
  end
  
  def view_less
    @comment = Comment.find(params[:id])
  end  
  

  # GET /replies/new
  def new
    @comment = Comment.find(params[:comment_id])
    @reply = Reply.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(reply_params)
    @reply.save
    @comment = @reply.comment
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    @reply.update(reply_params)
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to replies_url, notice: 'Reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:user_id, :comment_id, :content)
    end
end
