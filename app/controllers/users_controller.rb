class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :show_followers, :show_following, :show_user_posts]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  
  def user_ranking
    @ranked_users = User.where(id: Like.group(:target_user_id).order('count(target_user_id) desc').limit(100).pluck(:target_user_id))
    @top_articles = Post.all.limit(10)
    @top_users = User.all.limit(10)
    @posts = Post.order(created_at: :desc)
    @default_tags = ["business", "politics", "entertainment", "sports", "health", "tech", "education", "others"]
    @tags = Tag.where(name: @default_tags)
    @all_tags = Tag.all
    @users = User.all.limit(5)
  end
  
  def show
    @new_users = User.all.order(created_at: :desc).limit(10)
    @user_posts = Post.where(user_id: @user.id).order(created_at: :desc)
  end
  
  def show_followers
    @followers = @user.followers
  end
  
  def show_following
    @following = @user.following
  end
  
  def show_user_posts
    @user_posts = Post.where(user_id: @user.id).order(created_at: :desc)
  end

  # GET /users/new


  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :image, :provider, :about, :shoulder_name)
    end
end
