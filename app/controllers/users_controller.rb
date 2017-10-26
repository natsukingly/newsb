class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followers, :following, :posts]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def auto_complete
    @users = if params[:term] =~ /(@[^\s]+)\s.*/
             elsif user_name = params[:term].match(/(@[^\s]+)/)
               users = User.select('name').where('name LIKE ?', "%#{user_name[1].to_s[1..-1]}%")

               users.map {|user| {name: "#@{user.name}"} }
             end
    render json: @users.to_json
  end
  
  def extra_info
    @countries = Country.all
    @languages = Language.all
    
  end
  
  def complete_profile
    @user = User.find(user_id: current_user.id)
    @user.country = params[:user][:country_id]
    @user.language = params[:user][:language_id]
    @user.shoulder_name = params[:user][:shoulder_name]
    @user.about = params[:user][:about]
    @user.save
    
    redirect_to root_path
  end
  
  # def ranking
  #   @ranked_users = User.where(id: Like.group(:target_user_id).order('count(target_user_id) desc').limit(100).pluck(:target_user_id))
  #   @top_articles = Post.all.limit(10)
  #   @top_users = User.all.limit(10)
  #   @posts = Post.order(created_at: :desc)
  #   @default_tags = ["business", "politics", "entertainment", "sports", "health", "tech", "education", "others"]
  #   @tags = Tag.where(name: @default_tags)
  #   @all_tags = Tag.all
  #   @users = User.all.limit(5)
  # end
  
  def show
    @best_posts = @user.posts.order(likes_count: :desc).limit(3)
  end
  
  def posts
  end
  
  def following
  end

  def followers
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

  def change_country
    country = Country.find(params[:country_id])
    if current_user
      @user = User.find(current_user.id)
      @user.country_id = country.id
      @user.save
    else 
      cookie[:country] = country.name
    end
    redirect_to root_path
  end
  
  def change_language
    language = Language.find(params[:language_id])
    if current_user
      @user = User.find(current_user.id)
      @user.language_id = language.id
      @user.save
    else 
      cookie[:language] = language.code
    end
    redirect_to root_path
  end
      
  def notification_index
    @current_topic = "Notifications"
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
