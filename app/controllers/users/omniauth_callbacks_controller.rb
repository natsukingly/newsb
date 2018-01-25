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
						flash[:alert] = t('devise.signin.sns_already_connected')
						redirect_to redirect_to edit_sns_setting_user_path(current_user.id)
					# current_user.idと違う
					elsif @profile.present? && @profile.user_id != current_user.id 
						# ＞＞他のアカウントと結びついている
						flash[:alert] = t('devise.signin.sns_account_already_used')
						redirect_to edit_sns_setting_user_path(current_user.id)
					# 取得できたuid providerと一致するsocialprofileがない
					else
						# ＞＞social Profileを作ってユーザーをcurrent_user.idで紐づける
						@profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).new
						@profile.user = current_user
						@profile.set_values(@omniauth)
						@profile.save!
						flash[:notice] = t('devise.signin.sns_connection_success')
						redirect_to edit_sns_setting_user_path(current_user.id)
					end
				# SNSの情報を取得できなかった
				else
					#  ＞＞セッティングページにエラー
					flash[:alert] = t('devise.signin.sns_communication_failure')
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
							flash[:notice] = t('devise.signin.success')
							redirect_to cookies[:previous_url] || root_path
						end	
					# 取得できたuid providerと一致するsocialprofileがない
					else
						@existing_user = User.find_by(email: @omniauth['info']['email'])
						# 取得できたemailと一致するuserがいる
						if @existing_user
							# ＞＞他のアカウントが既にある。
							flash[:alert] = t('devise.signin.same_email_error')
							redirect_to cookies[:previous_url] || root_path
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
					flash[:alert] = t('devise.signin.communication_error')
					redirect_to cookies[:previous_url] || root_path		
				end
			end
		end
end
