class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :default_categories
    before_action :trending_tags
  
  
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:gender])
    end
  
    protected
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
end
