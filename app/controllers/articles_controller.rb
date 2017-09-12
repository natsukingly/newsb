class ArticlesController < ApplicationController
  before_action :default_tags, only: [:index, :show]
  before_action :sidebar, only: [:index, :show]

  def index
    if cookies[:search_preference]
      @articles = Article.all.where(category: cookies[:search_preference]).order(created_at: :desc).limit(5)
    else
      @articles = Article.order(created_at: :desc).limit(5)
    end
    @post = Post.new
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def load_more
    
    existing_articles = params[:existing_articles]
    
    if cookies[:search_preference]
      case params[:period]
      when "WEEK"
        @articles = Article.all.where(category: cookies[:search_preference]).where(published_time: 168.hours.ago..Time.now).order(created_at: :desc).offset(existing_articles).limit(5)
      when "MONTH"
        @articles = Article.all.where(category: cookies[:search_preference]).where(published_time: 720.hours.ago..Time.now).order(created_at: :desc).offset(existing_articles).limit(5)
      else
        @articles = Article.all.where(category: cookies[:search_preference]).where(published_time: 48.hours.ago..Time.now).order(created_at: :desc).offset(existing_articles).limit(5)
      end
    else
      @articles = Article.order(created_at: :desc).offset(existing_articles).limit(5)
    end
  end
  
end
