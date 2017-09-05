class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :default_tags, only: [:index, :autocomplete_personalized_tags, :autocomplete_tags, :load_url, :edit, :show, :article_index]
  before_action :sidebar, only: [:index, :show]

  


  # GET /posts
  # GET /posts.json
  def index
    @post = Post.new
    
    # top
    @selected_article = Post.last
    
    #sidebar


    if cookies[:personalized_tags]
      personalized_tags_ids = JSON.parse(cookies[:personalized_tags]).map { |str| str.to_i}
      @personalized_tags = Tag.where(id: personalized_tags_ids)
    end
    
    
    #main contents
    if cookies[:search_preference]
      @posts = Post.includes(:tags).where('tags.id' => JSON.parse(cookies[:search_preference])).order(created_at: :desc).limit(5)
    else
      @posts = Post.order(created_at: :desc).limit(5)
    end

  end
  
  def optimized_index
    @tags = Tag.where(id: params[:tag_ids])
    @show_tags = params[:tag_ids]
    if params[:tag_ids]
      cookies[:search_preference] = JSON.generate(params[:tag_ids])
      @post = Post.new
      @posts = Post.includes(:tags).where('tags.id' => (params[:tag_ids])).order(created_at: :desc).limit(5)
    else 
      cookies.delete :search_preference
      @posts = Post.order(created_at: :desc).limit(5)
    end
  end
  

  
  
  
  def post_index
    @posts = Post.order(created_at: :desc)
  end
  
  def show_article
    @article = Post.find(params[:article])
    @posts = Post.where(article_title: @article.article_title)
  end
  
  def mobile_post_form
  end
  
  def load_more_posts
    
    already_loaded_posts = params[:already_loaded_posts]
    
    if cookies[:search_preference]
      @posts = Post.includes(:tags).where('tags.id' => cookies[:search_preference]).order(created_at: :desc).offset(already_loaded_posts).limit(5)
    else
      @posts = Post.order(created_at: :desc).offset(already_loaded_posts).limit(5)
    end
  end
  
  
  
  # show_post
  def show
  end
  
  def autocomplete_tags
    # to deal with consecutive words and new lines without spacing
    input = params[:input].scan(/#\w+/)
    @last_word = input[0]
    
    @autocomplete_tag_lists = Tag.where('LOWER(name) LIKE(?)', "%#{@last_word.downcase.delete('#')}%").where.not(name: @default_categories).where.not(name: @default_rigions).limit(5)
  end
  
  # because differnt js needs to be applied
  def autocomplete_personalized_tags
    @last_word = params[:input]
    @autocomplete_tag_lists = Tag.where('LOWER(name) LIKE(?)', "%#{@last_word.downcase.delete('#')}%").where.not(name: @default_categories).where.not(name: @default_rigions).limit(5)
  end
  
  def reset_personalized_tags
    cookies.delete :personalized_tags
  end
  

  def customize_side_nav
    tag = Tag.find_by(name: params[:tag_name])

    if cookies[:personalized_tags]
      cookies[:personalized_tags] = JSON.generate(Array(tag.id.to_s).push(*JSON.parse(cookies[:personalized_tags])))
    else 
      cookies[:personalized_tags] = JSON.generate(Array(tag.id.to_s))
    end
    if cookies[:search_preference]
      cookies[:search_preference] = JSON.generate(Array(tag.id.to_s).push(*JSON.parse(cookies[:search_preference])))
    else
      cookies[:search_preference] = JSON.generate(Array(tag.id.to_s))
    end
    # personalized_tags_ids = JSON.parse(cookies[:personalized_tags]).map { |str| str.to_i}
    @personalized_tags = Tag.where(id: JSON.parse(cookies[:personalized_tags]))
  end
  
  def article_index
    @viral_articles = Post.select('distinct on (article_title) *')
    @post = Post.new
    @top_articles = Post.all.limit(10)
    @top_users = User.all.limit(10)
    
    #main contents
    @posts = Post.order(created_at: :desc)
  end
  
  
  def hashtags
    tag = Tag.find_by(name: params[:name])
    @posts = tag.posts
  end

  def search_tag
  end
    
  # GET /posts/new
  
  def load_url
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
    @posts = Post.page(params[:page])
    
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
    

    @post = Post.new(post_params)
    @post.content = params[:post][:content] + " " + "#" + params[:post][:tag]
    
    @post.user_id = current_user.id
    @post.remote_article_image_url = params[:post][:article_image].gsub('http:','https:')

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.update(post_params)
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
      params.require(:post).permit(:user_id, :article_image, :article_title, :article_url, :article_site, :article_published_time, :article_locale, :content)
    end
    
    def default_tags
      @default_categories = ["business", "politics", "entertainment", "sports", "health", "tech", "education", "others"]
      @default_rigions = ["U.S.", "China", "Europe", "Africa","Asia","Central America","Middle East","North America","Oceania","South America","The Caribbean"]
      @default_category_tags = Tag.where(name: @default_categories)
      @default_rigion_tags = Tag.where(name: @default_rigions)
    end
    
    def sidebar
      @top_articles = Post.where(id: Like.where(created_at: Date.today.beginning_of_week-1..Time.now ).group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
      @top_users = User.where(id: Like.where(created_at: Date.today.beginning_of_week-1..Time.now ).group(:target_user_id).order('count(target_user_id) desc').limit(10).pluck(:target_user_id))
    end
end
