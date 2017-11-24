class ApplicationController < ActionController::Base
		protect_from_forgery with: :exception
		before_action :configure_permitted_parameters, if: :devise_controller?
		before_action :default_categories
		before_action :trending_tags
		before_action :set_country
		before_action :set_locale
	
		def configure_permitted_parameters
				devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
				devise_parameter_sanitizer.permit(:sign_up, keys: [:gender])
		end
		
		# def after_sign_up_path_for(resource)
		#   bio_form_users_path(resource)
		# end
	
		# # # The path used after sign up for inactive accounts.
		# def after_inactive_sign_up_path_for(resource)
		#   bio_form_users_path(resource)
		# end
		# def after_sign_in_path_for(resource)
		#   bio_form_users_path(resource)
		# end

		#保留中　今はログインモーダルが開くタイミングで保存するようになっている。
		#_signin.html.hamlのjavascriptを参照
		def default_url_options(options = {})
		  { country: @country.name, locale: I18n.locale}.merge options
		end
		
		def store_location
			if (request.fullpath != new_user_registration_path &&
					request.fullpath != new_user_session_path &&
					request.fullpath != complete_profile_form_users_path &&
					request.fullpath != user_facebook_omniauth_authorize_path &&
					# request.fullpath.match(/\/auth\//) == false &&
					# request.fullpath != "/users/password" &&
					request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
					!request.xhr?)
					session[:previous_url] = request.fullpath 
			end
		end
		
		
		# @language, @country, I18n.localeの設定
		# 登録したユーザーは言語　国どちらも設定可能
	
		# 未登録のユーザーは
			# １　以前設定したセッティングを適用
			# ２　前のページからの引用（国と言語は一致）を適用
			# ３　IPから国を割り出して使う。（国と言語は一致）を適用
			# ４　デフォルトセッティング　アメリカ・英語を適用
		
		
		# def set_locale
		# 	if current_user
		# 		preferred_language_code = current_user.language.code
		# 		@country = current_user.country
		# 	#未登録だが言語と国の設定をしたことがある。	
		# 	elsif cookies[:preferred_language_code] && cookies[:preferred_country_id]
		# 		preferred_language_code = cookies[:preferred_language_code]
		# 		@county = Country.find(cookies[:preferred_country_id])
		# 	# 未登録だが言語の設定はしたことがある。	
		# 	elsif cookies[:preferred_language_code]
		# 		preferred_language_code = cookies[:preferred_language_code]
		# 		#ログインしたばかり
		# 		if cookies[:previous_county_id]
		# 			@country = Country.find(cookie[:previous_county_id])
		# 		end
		# 		detect_locale
		# 	elsif cookies[:preferred_country_id]
		# 	# 1
		# 		@country = Country.find(cookies[:preferred_country_id])
		# 		preferred_language_code = @country.language.code

		# 	else
		# 	# 2
		# 		detect_locale
		# 		detected_locale_code = @country.language.code
		# 	end
			
		# 	recorded_country = Country.find_by(name: params[:country])
			
		# 	I18n.locale = preferred_language_code || recorded_country.language.code || detected_locale_code || I18n.default_locale
		# 	@language = Language.find_by(code: I18n.locale)
		# end
		
		# def set_country
		# 	if user_signed_in?
		# 		@country = current_user.country
		# 		@language = current_user.language
		# 	elsif cookies[:country]
		# 		@country = Country.find_by(name: cookies[:country])

		# 	else
		# 		#this method detect locale and save it to cookies
		# 		detect_locale
		# 		cookies[:language] = @country.language.code
		# 		@language = Language.find_by(code: cookies[:language])
		# 	end
		# end
				
		
		
		
		protected
				def detect_locale
					ip = request.remote_ip
					if ip
						country_name = Geocoder.search(ip).first.country
						country = Country.find_by(name: country_name)
						if country 
							cookies[:country] = country.name
						else 
							cookies[:country] = "United States"
						end
						@country = Country.find_by(name: cookies[:country])
					else
						@country = Country.find_by(name: "United States")
					end
				end
				
				def set_locale
					if current_user
						preferred_language_code = current_user.language.code
						@country = current_user.country
					elsif params[:locale]
						preferred_language_code = params[:locale]
					else
						detect_locale
						detected_locale_code = @country.language.code
					end
					I18n.locale = preferred_language_code || detected_locale_code || I18n.default_locale
					@language = Language.find_by(code: I18n.locale)
				end
		
				def set_country
					if params[:country]
						@country = Country.find_by(name: params[:country])
					elsif current_user
						@county = Country.find(current_user.country_id)
					else
						detect_locale
					end
				end
				
				def authenticate_user!
						if user_signed_in?
								super
						else
								redirect_to about_path, :notice => 'please sign-up'
								## if you want render 404 page
								## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
						end
				end
				
				def default_categories
					@categories = Category.all
				end
				
				def trending_tags
					@trending_tags = Tag.order(:weekly_posts_count).limit(10)
				end
				
				def yes_found
					@not_found = false
				end
				
				def set_new_users
					if current_user
						@new_users = User.where(country_id: @country.id).where.not(id: current_user.id).order(created_at: :desc).limit(3)
					else
						@new_users = User.where(country_id: @country.id).order(created_at: :desc).limit(3)
					end
				end
			
end
