class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  


  # GET /posts
  # GET /posts.json
  def index
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
    @show_form = false
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  
  def load_url
    require 'nokogiri'
    @show_form = true
    @article_url = params[:placeholder_url]
    
    url = @article_url
    charset = nil
    html = open(url) do |f|
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
    
    unless doc.css('//meta[property="og:image"]/@content').empty?
      @article_image = doc.css('//meta[property="og:image"]/@content').to_s
    end
    
    @post = Post.new
    @posts = Post.all.order(created_at: :desc)
    
    render :index
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
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
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :content, :article_title, :article_image, :article_url, :article_site)
    end
end
