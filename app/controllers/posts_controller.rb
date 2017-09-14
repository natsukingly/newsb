class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :default_tags, only: [:index, :autocomplete_personalized_tags, :autocomplete_tags, :load_url, :edit, :show, :article_index]
  before_action :sidebar, only: [:index, :show, :article_index]
  before_action :yes_found
  


  # GET /posts
  # GET /posts.json
  def index
    @post = Post.new
    
    #main contents

    @posts = Post.order(created_at: :desc).limit(5)

    not_found
  end
  
  # def optimized_index
  #   @tags = Tag.where(id: params[:tag_ids])
  #   @show_tags = params[:tag_ids]
  #   if params[:tag_ids]
  #     cookies[:search_preference] = JSON.generate(params[:tag_ids])
  #     @post = Post.new
  #     @posts = Post.includes(:tags).where('tags.id' => (params[:tag_ids])).order(created_at: :desc).limit(5)
  #   else 
  #     cookies.delete :search_preference
  #     @posts = Post.order(created_at: :desc).limit(5)
  #   end
  # end

  def post_index
    @posts = Post.order(created_at: :desc)
  end
  
  
  # def mobile_post_form
  # end
  
  def load_more
    
    existing_posts = params[:existing_posts]
    
    if cookies[:search_preference]
      @posts = Post.where(category: cookies[:search_preference]).order(created_at: :desc).offset(existing_posts).limit(5)
    else
      @posts = Post.order(created_at: :desc).offset(existing_posts).limit(5)
    end
    
    not_found
  end
  
  
  
  # show_post
  def show
    @comment = Comment.new
  end
  
  def autocomplete_tags
    # to deal with consecutive words and new lines without spacing
    input = params[:input].scan(/#\w+/)
    @last_word = input[0]
    
    @autocomplete_tag_lists = Tag.where('LOWER(name) LIKE(?)', "%#{@last_word.downcase.delete('#')}%").where.not(name: @default_categories).where.not(name: @default_rigions).limit(5)
  end
  
  # because differnt js needs to be applied
  # def autocomplete_personalized_tags
  #   @last_word = params[:input]
  #   @autocomplete_tag_lists = Tag.where('LOWER(name) LIKE(?)', "%#{@last_word.downcase.delete('#')}%").where.not(name: @default_categories).where.not(name: @default_rigions).limit(5)
  # end
  
  # def reset_personalized_tags
  #   cookies.delete :personalized_tags
  # end
  

  # def customize_side_nav
  #   tag = Tag.find_by(name: params[:tag_name])

  #   if cookies[:personalized_tags]
  #     cookies[:personalized_tags] = JSON.generate(Array(tag.id.to_s).push(*JSON.parse(cookies[:personalized_tags])))
  #   else 
  #     cookies[:personalized_tags] = JSON.generate(Array(tag.id.to_s))
  #   end
  #   if cookies[:search_preference]
  #     cookies[:search_preference] = JSON.generate(Array(tag.id.to_s).push(*JSON.parse(cookies[:search_preference])))
  #   else
  #     cookies[:search_preference] = JSON.generate(Array(tag.id.to_s))
  #   end
  #   # personalized_tags_ids = JSON.parse(cookies[:personalized_tags]).map { |str| str.to_i}
  #   @personalized_tags = Tag.where(id: JSON.parse(cookies[:personalized_tags]))
  # end
  

  
  
  def hashtags
    tag = Tag.find_by(name: params[:name])
    @posts = tag.posts
  end

  def search_tag
  end
    
  # GET /posts/new
  
  def load_url
    @article_url = params[:placeholder_url]

    url = @article_url
    charset = nil
    html = open(url, 'User-Agent' => 'firefox') do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    # ノコギリを使ってhtmlを解析
    doc = Nokogiri::HTML.parse(html, charset)
    
    if doc.css('//meta[property="og:title"]/@content').empty?
      @article_title = doc.title.to_s
    else
      @article_title = doc.css('//meta[property="og:title"]/@content').to_s
    end
    
    if doc.css('//meta[property="og:site_name"]/@content').empty?
      @article_source = doc.title.to_s
    else
      @article_source = doc.css('//meta[property="og:site_name"]/@content').to_s
    end
    
    if doc.css('//meta[property="og:image"]/@content').empty?
      @article_image = "noimage.jpg"
    else
      @article_image = doc.css('//meta[property="og:image"]/@content').to_s
    end
    
    if doc.css('//meta[property="article:published_time"]/@content').empty?
      @article_published_time = "unknown"
    else
      @article_published_time = doc.css('//meta[property="article:published_time"]/@content').to_s
    end

    @post = Post.new
    @article = Article.new
    
  end
  
  def mobile_load_url
    @article_url = params[:placeholder_url]
    @default_tags = ["business", "politics", "entertainment", "sports", "health", "tech", "education", "others"]
    
    url = @article_url
    charset = nil
    html = open(url, 'User-Agent' => 'firefox') do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    # ノコギリを使ってhtmlを解析
    doc = Nokogiri::HTML.parse(html, charset)
    
    if doc.css('//meta[property="og:title"]/@content').empty?
      @article_title = doc.title.to_s
    else
      @article_title = doc.css('//meta[property="og:title"]/@content').to_s
    end
    
    if doc.css('//meta[property="og:site_name"]/@content').empty?
      @article_site = doc.title.to_s
    else
      @article_site = doc.css('//meta[property="og:site_name"]/@content').to_s
    end
    
    if doc.css('//meta[property="og:image"]/@content').empty?
      @article_image = "noimage.jpg"
    else
      @article_image = doc.css('//meta[property="og:image"]/@content').to_s
    end
    
    if doc.css('//meta[property="article:published_time"]/@content').empty?
      @article_published_time = "unknown"
    else
      @article_published_time = doc.css('//meta[property="article:published_time"]/@content').to_s
    end
    
    if doc.css('//meta[property="og:locale"]/@content').empty?
      @article_locale = "unknown"
    else
      @article_locale = doc.css('//meta[property="og:locale"]/@content').to_s
    end
    
    @post = Post.new
    
  end
  
  

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @article = Article.find_by(title: params[:article][:title])
    if @article == nil
      @article = Article.new(article_params)
      @article.remote_image_url = params[:article][:image].gsub('http:','https:')
      @article.category = params[:tag][:category]
      @article.region = params[:tag][:region] 
      @article.save
    end
    
    @post = current_user.posts.build(article_id: @article.id)
    @post.category = params[:tag][:category]
    @post.region = params[:tag][:region]
    @post.content = params[:post][:content] + " " + "#" + params[:tag][:category] + " " + "#" + params[:tag][:region]
    
    @post.save
    if @article.category != @post.category
      a_category_count = @article.posts.where(category: @article.category).count 
      p_category_count = @article.posts.where(category: @post.category).count
      if p_category_count > a_category_count
        @article.category = @post.category
        @article.save
      end
    end
    if @article.region != @post.region
      a_region_count = @article.posts.where(region: @article.region).count 
      p_region_count = @article.posts.where(region: @post.region).count
      if p_region_count > a_region_count
        @article.region = @post.region
        @article.save
      end
    end
      
    # this needs to be optimized
    @posts = Post.all.order(created_at: :desc)
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @article = @post.article

    @post.category = params[:tag][:category]
    @post.region = params[:tag][:region]
    @post.content = params[:post][:content] + " " + "#" + params[:tag][:category] + " " + "#" + params[:tag][:region]
    
    @post.save
    if @article.category != @post.category
      a_category_count = @article.posts.where(category: @article.category).count 
      p_category_count = @article.posts.where(category: @post.category).count
      if p_category_count > a_category_count
        @article.category = @post.category
        @article.save
      end
    end
    if @article.region != @post.region
      a_region_count = @article.posts.where(region: @article.region).count 
      p_region_count = @article.posts.where(region: @post.region).count
      if p_region_count > a_region_count
        @article.region = @post.region
        @article.save
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content)
    end
    
    def article_params
      params.require(:article).permit(:title, :source, :url, :published_time)
    end
    
    def article_image_params
      params.require(:article).permit(:image)
    end
    
    def not_found
      if @posts.empty?
        @not_found = true
      end
    end
    
end
