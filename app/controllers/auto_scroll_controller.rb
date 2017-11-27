class AutoScrollController < ApplicationController
  
  # articles
  
  def load_articles
    #featured_article = 1
    @existing_articles = params[:existing_articles].to_i + 1
    @loaded_articles = Article.where(country_id: @country.id).order(likes_count: :desc).offset(@existing_articles).limit(1)
  end
  
  def load_categorized_articles
    #featured_article = 1
    @existing_articles = params[:existing_articles].to_i + 1
    @loaded_articles = Article.where(country_id: @country.id, category_id: params[:category_id]).order(likes_count: :desc).offset(@existing_articles).limit(1)
  end
  
  def load_searched_articles
    @existing_articles = params[:existing_articles].to_i
    @keyword = params[:keyword]
    @loaded_articles = Article.where('LOWER(title) LIKE(?)', "%#{@keyword.downcase}%").order(likes_count: :desc).offset(@existing_articles).limit(1)
  end

  # posts

  def load_posts
    @existing_posts = params[:existing_posts].to_i
    @loaded_posts = Post.where(country_id: @country.id).order(created_at: :desc).includes(:user, :article).offset(@existing_posts).limit(1)
  end
  
  def load_user_posts
    @existing_posts = params[:existing_posts].to_i
    @loaded_posts = Post.where(user_id: params[:user_id]).includes(:article).order(created_at: :desc).offset(@existing_posts).limit(1)
  end
  
  def load_searched_posts
    @existing_posts = params[:existing_posts].to_i
    @keyword = params[:keyword]
    @loaded_posts = Post.where('LOWER(content) LIKE(?)', "%#{@keyword.downcase}%").order(likes_count: :desc).offset(@existing_posts).limit(1)
  end
  
  
  # tags
  
  def load_trending_tags
    @existing_tags = params[:existing_tags].to_i
    @loaded_tags = Tag.where(country_id: @country.id).order(created_at: :desc).offset(@existing_tags).limit(1)
  end
  
  def load_favorite_tags
    @existing_tags = params[:existing_tags].to_i
    @loaded_tags = current_user.favorite_tags.order(created_at: :desc).offset(@existing_tags).limit(1)
  end
  
  def load_searched_tags
    @existing_tags = params[:existing_tags].to_i
    @keyword = params[:keyword]
    @loaded_tags = Tag.where(country_id: @country.id).where('LOWER(name) LIKE(?)', "%#{@keyword.downcase}%").order(created_at: :desc).offset(@existing_tags).limit(1)
  end
  
  
  #notification
  def load_notifications
    @existing_notifications = params[:existing_notifications].to_i
    @loaded_notifications = current_user.notifications.includes(:target_user).order(created_at: :desc).offset(@existing_notifications).limit(1)
  end
  
  
  #user
  def load_weekly_users
    @existing_users = params[:existing_users].to_i
    @loaded_users = User.where(country_id: @country.id).order(weekly_liked_count: :desc).offset(@existing_users).limit(1)
  end
  
  def load_all_time_users
    @existing_users = params[:existing_users].to_i
    @loaded_users = User.where(country_id: @country.id).order(liked_count: :desc).offset(@existing_users).limit(1)
  end
  
  def load_followers
    @existing_users = params[:existing_users].to_i
    @user = User.find(params[:user_id])
    @loaded_users = @user.followers.order(liked_count: :desc).offset(@existing_users).limit(1)
  end
  
  def load_following
    @existing_users = params[:existing_users].to_i
    @user = User.find(params[:user_id])
    @loaded_users = @user.following.order(liked_count: :desc).offset(@existing_users).limit(1)
  end
  
  def load_searched_users
    @existing_users = params[:existing_users].to_i
    @keyword = params[:keyword]
    @loaded_users = User.where(country_id: @country.id).where('LOWER(name) LIKE(?)', "%#{@keyword.downcase}%").order(liked_count: :desc).offset(@existing_users).limit(1)
  end
  
  
end
