class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  def new
    respond_to do |format|
      format.js
    end
  end

  ####### option 1 #######
  # def create
  #   resource = warden.authenticate!(auth_options)
  #   set_flash_message(:notice, :signed_in) if is_navigational_format?
  #   sign_in(resource_name, resource)
  #   respond_with resource, :location => after_sign_in_path_for(resource)
  # end

  # # 認証が失敗した場合に呼び出されるアクション
  # def failed
  #   # warden で出力されたエラーを保存する
  #   flash[:failure_message] = "invalid password"
  #   redirect_to root_path
    
  # end

  # protected
  #   def auth_options
  #     # 失敗時に recall に設定したパスのアクションが呼び出されるので変更
  #     # { scope: resource_name, recall: "#{controller_path}#new" } # デフォルト
  #     { scope: resource_name, recall: "#{controller_path}#failed" }
  #   end
  
  #################################
  
  # prepend_before_action :check_unconfirmed_user, if: -> { request.xhr? }
  # skip_before_action :verify_authenticity_token, only: [:destroy, :create]

  # def create
  #   if params[:format] == 'js'
  #     opts = auth_options
  #     opts[:recall] = "#{controller_path}#failure"
  #     self.resource = warden.authenticate!(opts)
  #     sign_in(resource_name, resource)
  #   else
  #     super
  #   end
  # end

  # def failure
  #   flash[:fail] = "yo"
  #   render partial: 'sessions/error_message'
  # end

  # private
  #   def check_unconfirmed_user
  #     puts params
  #     unless params[:user][:email].blank?
  #       user = User.find_by(email: params[:user][:email])
  #       if user && !user.confirmed?
  #         flash.now[:notice] = I18n.t('devise.failure.unconfirmed')
  #         render partial: 'shared/js/notify'
  #         return
  #       end
  #     end
  #   end
  
  
  
  
  
  
  
  
  
  
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
