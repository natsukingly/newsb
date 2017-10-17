class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :default_categories
    before_action :trending_tags
    before_action :set_country
  
  
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:gender])
    end
    
    def after_sign_up_path_for(resource)
      bio_form_users_path(resource)
    end
  
    # # The path used after sign up for inactive accounts.
    def after_inactive_sign_up_path_for(resource)
      bio_form_users_path(resource)
    end
    # def after_sign_in_path_for(resource)
    #   bio_form_users_path(resource)
    # end
    
    
    def set_country
      if user_signed_in?
        @country = current_user.country
        @language = current_user.language
      elsif cookie[:country]
        @country = Country.find_by(name: cookie[:country])
        @language = Language.find_by(name: cookie[:language])
      else
        #this method detect locale and save it to cookie
        detect_locale
        cookie[:language] = @country.language.language_code
        @language = Language.find_by(name: cookie[:language])
      end
    end
        
    
    
    
    protected
        def detect_locale
          ip = request.remote_ip
          if ip
            country_name = Geocoder.search(ip).first.country
            country = Country.find_by(name: country_name)
            if country 
              cookie[:country] = country
            else 
              cookie[:country] = "United States"
            end
          end
          @country = Country.find_by(name: cookie[:country])
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
end
