class Category < ApplicationRecord
    has_many :posts
    has_many :post_drafts
    has_many :articles
    
    def translated_name
        I18n.t('categories.' + self.name.downcase)
    end
end
