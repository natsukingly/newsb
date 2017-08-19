class Post < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :comments
    has_and_belongs_to_many :tags, dependent: :destroy 
    
    attr_accessor :tag

    mount_uploader :article_image, ArticleImageUploader
    
    after_create do
        post = Post.find_by(id: self.id)
        hashtags = self.content.scan(/#\w+/)
        hashtags.uniq.map do |hashtag|
          tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
          post.tags << tag
        end
    end
  
 
    before_update do
        post = Post.find_by(id: self.id)
        post.tags.clear
        hashtags = self.content.scan(/#\w+/)
        hashtags.uniq.map do |hashtag|
          tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
          post.tags << tag
        end
    end
    
end
