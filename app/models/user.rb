class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google, :linkedin, :twitter]
  mount_uploader :image, ImageUploader
  
  has_many :social_profiles, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :feed_notifications, dependent: :destroy

  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "following_id", dependent: :destroy  
  has_many :following, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :favorites
  has_many :favorite_tags, through: :favorites, source: :tag
  
  belongs_to :country
  belongs_to :language
  
  before_destroy :destroy_notifications
  
  # devise
  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end
  
  def linkedin_client
    client = LinkedIn::Client.new(ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'])
    client.authorize_from_access(self.social_profile(:linkedin).access_token)
    client
  end
  
  def self.create_from_omniauth(auth)
    create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.remote_image_url = auth.info.image.gsub('http:','https:') # assuming the user model has an image
      if auth.extra.raw_info.cover
        user.cover = auth.extra.raw_info.cover.source 
      else 
        user.cover = "/assets/cover.jpg"
      end 
      user.gender = auth.extra.raw_info.gender

      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  
  def destroy_notifications
    notifications = Notification.where(target_user_id: self.id)
    notifications.delete_all
  end
  
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  

  
  
  class << self
    
    def reset_weekly_liked_count
      self.find_each do |user|
        user.weekly_liked_count = 0
        user.save
      end
    end
    
  end
end