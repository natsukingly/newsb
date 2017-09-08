class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  
  
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
        
        def default_tags
          @default_categories = ["business", "politics", "entertainment", "sports", "health", "tech", "education", "others"]
          @default_regions = ["U.S.", "China", "Europe", "Africa","Asia","Central America","Middle East","North America","Oceania","South America","The Caribbean"]
          @default_category_tags = Tag.where(name: @default_categories)
          @default_region_tags = Tag.where(name: @default_regions)
          
          if cookies[:personalized_tags]
            personalized_tags_ids = JSON.parse(cookies[:personalized_tags]).map { |str| str.to_i}
            @personalized_tags = Tag.where(id: personalized_tags_ids)
          end
        end
        
        def sidebar
          @top_articles = Article.where(id: Like.where(created_at: Date.today.beginning_of_week-1..Time.now ).group(:article_id).order('count(article_id) desc').limit(10).pluck(:article_id))
          @top_users = User.where(id: Like.where(created_at: Date.today.beginning_of_week-1..Time.now ).group(:target_user_id).order('count(target_user_id) desc').limit(10).pluck(:target_user_id))
        end
end
