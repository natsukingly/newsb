class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :load_more_posts]
  before_action :set_side_articles, only: [:show]
  before_action :yes_found 

  def index
    if cookies[:search_preference]
      @articles = Article.all.where(category: cookies[:search_preference]).order(created_at: :desc).limit(5)
    else
      @articles = Article.order(created_at: :desc).limit(10)
    end
    @post = Post.new
  end
  
  def show
    @current_topic = "Comments"
    @fake_news_reports = @article.posts.where(fake_news_report: true).order(likes_count: :desc)
    
    if current_user
      @your_posts = @article.posts.where(fake_news_report: false).where(user_id: current_user.id)
      @best_posts = @article.posts.where(fake_news_report: false).order(likes_count: :desc).limit(3)
      @shared_posts = @article.posts.where(content: "").where.not(user_id: current_user.id).order(created_at: :asc)
      @follower_posts = @article.posts.where(fake_news_report: false).where(user_id: current_user.followers.ids).where.not(id: @best_posts.ids).where.not(id: @shared_posts.ids)
      
      
      inapplicable_ids = @your_posts.ids + @best_posts.ids + @follower_posts.ids + @shared_posts.ids
      @new_posts = @article.posts.where(fake_news_report: false).where.not(id: inapplicable_ids).order(created_at: :desc).limit(30)
    else
      @your_posts = []
      @best_posts = @article.posts.where(fake_news_report: false).order(likes_count: :desc).limit(3)
      @follower_posts = []
      @shared_posts = @article.posts.where(content: "")
      inapplicable_ids = @best_posts.ids + @shared_posts.ids
      
      @new_posts = @article.posts.where(fake_news_report: false).where.not(id: inapplicable_ids).order(created_at: :desc).limit(30)
    end
  end
  
  private 
    def not_found
      if @articles.empty?
        @not_fount = true
      end
    end
    
    def set_article
      @article = Article.find(params[:id])
    end
    
    def set_side_articles
      @side_articles = Article.where(category_id: @article.category_id, country_id: @article.country_id).where.not(id: @article.id).order(likes_count: :desc).limit(5)
    end
    
end
