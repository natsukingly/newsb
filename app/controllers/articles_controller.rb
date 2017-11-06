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
    if current_user
      @shared_posts = @article.posts.where(content: "")
      shared_posts_ids = @shared_posts.ids
      @your_posts = @article.posts.where(user_id: current_user.id).where.not(id: shared_posts_ids)
      @best_posts = @article.posts.where.not(id: shared_posts_ids).order(likes_count: :desc).limit(3)
      @follower_posts = @article.posts.where(user_id: current_user.followers.ids).where.not(id: shared_posts_ids).where.not(id: @best_posts.ids)
      inapplicable_ids = @your_posts.ids + @best_posts.ids + @follower_posts.ids + shared_posts_ids
      @new_posts = @article.posts.where.not(id: inapplicable_ids).order(created_at: :desc)
    else
      @shared_posts = @article.posts.where(content: "")
      shared_posts_ids = @shared_posts.ids
      @your_posts = []
      @best_posts = @article.posts.where.not(id: shared_posts_ids).order(likes_count: :desc).limit(3)
      @follower_posts = []
      inapplicable_ids = @best_posts.ids + shared_posts_ids
      @new_posts = @article.posts.where.not(id: inapplicable_ids).order(created_at: :desc)
    end
  end
  
  def load_more_posts
    existing_article_posts = params[:existing_article_posts]
    @posts = Post.includes([:user]).sortByLikes(Like.recent.offset(existing_article_posts).limit(5).popularPosts(@article.posts.ids))
  end
  
  def load_more
    
    existing_articles = params[:existing_articles]
    @articles = Article.order(created_at: :desc).offset(existing_articles).limit(5)

    not_found
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
