class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followers, :following, :posts, :save_setting, :save_email_setting, :save_password_setting, :edit_setting, :edit_locale_setting, :edit_password_setting, :edit_email_setting, :edit_sns_setting]
  before_action :set_new_users, only: [:notification_index, :show]
  before_action :authenticate_user_for_setting, only: [:complete_profile_form, :edit_setting, :edit_locale_setting, :edit_email_setting, :edit_password_setting,
  :save_setting, :save_locale_setting, :save_email_setting, :save_password_setting]
  
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
  
  # def create
  #   @user = User.new(params[:user])
  #   if @user.save
  #     sign_in @user
  #     flash[:notice] = "Welcome to Banking Analytics."
  #     redirect_to root_path
  #   end
  # end
  
  def complete_profile_form
    @countries = Country.all
    @languages = Language.all
    
  end
  
  def complete_profile
    @user = User.find(current_user.id)
    @user.country_id = params[:user][:country_id].to_i
    @user.language_id = params[:user][:language_id].to_i
    @user.credential = params[:user][:credential]
    @user.about = params[:user][:about]
    if @user.save
      flash[:notice] = t('flash.user.update_setting_success')
      redirect_to cookies[:previous_url] || root_path
    else
      flash[:alert] = t('flash.general_error')
      redirect_to cookies[:previous_url] || root_path
    end
  end
  
  # def error_message
  #   @error_message = "invalid"
  # end
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
    @posts = @user.posts.order(created_at: :desc).limit(30)
  end
  
  def edit_setting
    @current_topic = t('nav.topic.setting')
  end
  
  def edit_locale_setting
    @current_topic = t('nav.topic.setting')
  end
  
  def edit_email_setting
    @current_topic = t('nav.topic.setting')
  end
  
  def edit_password_setting
    @current_topic = t('nav.topic.setting')
    @minimum_password_length = 6
  end
  
  def save_setting
    @user.update(user_params)
    if @user.save 
      flash[:notice] = t('flash.user.update_setting_success')
      redirect_to current_user
    else
      flash[:alert] = t('flash.general_error')
      redirect_to edit_setting_user_path(current_user)
    end
  end
  
  def save_locale_setting
    if @user.update(user_param)
      flash[:notice] = t('flash.user.update_setting_success')
      redirect_to current_user
    else
      flash[:alert] = t('flash.general_error')
      redirect_to edit_locale_setting_user_path(current_user)    
    end
  end
  
  # def save_email_setting
  #   @email = params[:user][:email]
  #   @confirmation_email = params[:user][:email_confirmation]
  #   if @email == @confirmation_email
  #     if !(User.where(email: @email).any?)
  #       @user.update(email: @email)
  #       if @user.save 
  #         flash[:notice] = "Your email has been successfully updated"
  #         redirect_to current_user
  #       end
  #     else
  #       @taken_email_error = "this address is already registered by another user"
  #       render :edit_email_setting
  #     end
  #   else
  #     @matching_error = "Adresses did not match"
  #     render :edit_email_setting
  #   end
  # end
  
  # def save_password_setting
  #   @password = params[:user][:password]
  #   @password_confirmation = params[:user][:password_confirmation]
  #   @current_password = params[:user][:current_password]
  #   respond_to do |format|
  #     if current_user.update_with_password(password: @password, password_confirmation: @password_confirmation, current_password: @current_password)
  #       # パスワードを変更するとログアウトしてしまうので、再ログインが必要
  #       sign_in(current_user, bypass: true)
  #       format.html { redirect_to edit_setting_user_path(current_user) }
  #     else
  #       format.html { render :edit_setting_password }
  #     end
  #   end
  # end
    
  
  
  def posts
    @posts = @user.posts.includes(:article).order(created_at: :desc).limit(30)
  end
  
  def drafts
    @post_drafts = current_user.post_drafts.order(created_at: :desc).includes(:article).limit(30)
  end
  
  def following
    @users = @user.following.order(liked_count: :desc).limit(30)
  end

  def followers
    @users = @user.followers.order(liked_count: :desc).limit(30)
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
    @country = Country.find_by(name: params[:country_name])
    if current_user
      @user = User.find(current_user.id)
      @user.country_id = @country.id
      if @user.save
        flash[:notice] = "success"
        redirect_to root_path
      else
        flash[:alert] = "failure"
        redirect_to root_path
      end
    else
      cookies[:country] = @country.name
      redirect_to root_path(country: @country.name)
    end
  end
  
  def change_language
    @language = Language.find_by(code: params[:code])
    if current_user
      @user = User.find(current_user.id)
      @user.language_id = @language.id
      @user.save
    end
    cookies[:language] = @language.name
    redirect_url = cookies[:previous_url]
    cookies.delete :previous_url
    redirect_to root_path(locale: @language.code)
  end
      
      
      
  def notification_index
    @current_topic = "Notifications"
  end

  def check_notifications
    notifications = current_user.notifications.where(check: false)
    notifications.each do |notification|
      notification.check = true
      notification.save
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :image, :provider, :about, :credential, :country_id, :language_id)
    end
    
    def password_params
      params.require(:user).permit(:current_password, :new_password, :password_confirmation)
    end
    
    def authenticate_user_for_setting
      unless current_user && current_user.id == params[:id].to_i
        flash[:notice] = "You are not allowed to access this page."
        redirect_to root_path
      end
    end
end
