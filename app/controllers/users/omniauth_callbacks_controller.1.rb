class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

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
		
		#Userがログインしている場合
		if current_user
			# SNSの情報を取得できた
			if @omniauth.present?
				# 取得できたuid providerと一致するsocialprofileがある
				@profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
				# current_user.idと一緒
				if @profile.present? && @profile.user_id == current_user.id 
					# ＞＞連携済み
					flash[:notice] = "This sns account has already been connected"
					redirect_to redirect_to edit_sns_setting_user_path(current_user.id)
				# current_user.idと違う
				elsif @profile.present? && @profile.user_id != current_user.id 
					# ＞＞他のアカウントと結びついている
					flash[:notice] = "This sns account is being used for another NEWSB account."
					redirect_to edit_sns_setting_user_path(current_user.id)
				# 取得できたuid providerと一致するsocialprofileがない
				else
					# ＞＞social Profileを作ってユーザーをcurrent_user.idで紐づける
					@profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).new
					@profile.user = current_user
					@profile.set_values(@omniauth)
					@profile.save!
					flash[:notice] = "you successfully connected with #{@omniauth['provider']}"
					redirect_to edit_sns_setting_user_path(current_user.id)
				end
			# SNSの情報を取得できなかった
			else
				#  ＞＞セッティングページにエラー
				flash[:notice] = "We were unable to access to your sns account information."
				redirect_to redirect_to edit_sns_setting_user_path(current_user.id)					
			end
		#Userがログインしていない場合
		else
			# SNSの情報を取得できた
			if @omniauth.present?
				@profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
				#取得できたuid providerと一致するsocialprofileがある
				if @profile.present? 
					# ＞＞ログイン
					sign_in @profile.user
					# ＞＞初めてのログインの場合は設定ページにリダイレクト
					if @profile.user.sign_in_count <= 30
						redirect_to complete_profile_form_users_path
					# ＞＞２回目以降はのログインの場合はログイン前にいた場所かトップにリダイレクト
					else
						redirect_to cookies[:previous_url] || root_path
					end	
				# 取得できたuid providerと一致するsocialprofileがない
				else
					@existing_user = User.find_by(email: @omniauth['info']['email'])
					# 取得できたemailと一致するuserがいる
					if @existing_user
						# ＞＞他のアカウントが既にある。
						flash[:notice] = "There is already an account with this email."
						render "errors/login_existing_account.js.erb"
					# 取得できたemailと一致するuserがない
					else
						# ＞＞他のアカウントはまだない。サインアップ
						@profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).new
						@profile.user = User.create_from_omniauth(@omniauth)
						@profile.set_values(@omniauth)
						@profile.save!
						sign_in @profile.user
						redirect_to complete_profile_form_users_path
					end
				end
			# SNSの情報を取得できなかった	
			else
				# ＞＞サインインページにエラー
				flash[:notice] = "We were unable to access to your sns account information."
				render "errors/login_no_sns_info.js.erb"			
			end
		end
	end
	  
	  
	  
  
  
  
  
  def basic_action
	#SNSから情報ゲットリクエスト
	@omniauth = request.env['omniauth.auth']

	if @omniauth.present?
	  @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
	  unless @profile
		@profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).new
		@existing_user = User.find_by(email: @omniauth['info']['email'])
		if current_user
		  @profile.user = current_user
		else
		  @profile.user = User.create_from_omniauth(@omniauth)

		end
		@profile.save!
	  end
	  @profile.set_values(@omniauth)
	  if current_user
		flash[:notice] = "you successfully connected with #{@omniauth['provider']}"
		redirect_to edit_sns_setting_user_path(current_user.id)
	  else
		if @profile.user.persisted?
		  sign_in @profile.user
		  if @profile.user.sign_in_count <= 30
			redirect_url = complete_profile_form_users_path
		  else
			redirect_url = cookies[:previous_url] || root_path
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
