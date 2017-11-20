class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in @user, :event => :authentication #this will throw if @user is not activated
  #     if @user.sign_in_count <= 1
  #       redirect_url = profile_form_users_path(@user)
  #     else
  #       redirect_url = root_path
  #     end
  #     redirect_to redirect_url
  #     set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

  def failure
    redirect_to root_path
  end

  def facebook; basic_action; end
  def google; basic_action; end
  def linkedin; basic_action; end
  def twitter; basic_action; end

  private
  def basic_action
    #SNSから情報ゲットリクエスト
    @omniauth = request.env['omniauth.auth']
    # 問題なく情報ゲットの場合

    if @omniauth.present?
      # その情報と一致するアカウントを検索
      @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
      # その情報と一致するアカウントがなかった場合（初めてそのSNS情報を使用）
      unless @profile
        # その情報と一致するアカウントがなかった場合（初めてそのSNS情報を使用）
        @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).new
        #同じemailのアカウントがあるか確認。
        @existing_user = User.find_by(email: @omniauth['info']['email'])
        #同じemailアカウントがある場合、redirectしてそのアカウントで入ってからSNSでコネクトするようインスト楽とする。
        #ログインしていない、同じe-mailのアカウントがない場合、snsの情報をもとにユーザーを作成。
        if current_user
          @profile.user = current_user
        else
          @profile.user = User.create_from_omniauth(@omniauth)
        end
        @profile.save!
      end
      @profile.set_values(@omniauth)
      #userがサインインしている場合、javascriptを実行。
      #userがサインインしてなかった場合、リダイレクト
      if current_user
        flash[:notice] = "you success fully connected with #{@omniauth['provider']}"
        redirect_to sns_setting_user_path(current_user.id)
      else
        if @profile.user.persisted?
          sign_in @profile.user
          if @profile.user.sign_in_count <= 10
            redirect_url = complete_profile_form_users_path
          else
            redirect_url = session[:previous_url] || root_path
          end
          redirect_to redirect_url
          set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    end
  end
end
