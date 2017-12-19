class Contact < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :message, presence: true
    mount_uploader :image, ContactImageUploader
    
    belongs_to :user
    
end
