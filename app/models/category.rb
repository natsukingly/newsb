class Category < ApplicationRecord

    has_many :articles, :dependent => :destroy
    
    def translated_name
        I18n.t('categories.' + self.name.downcase)
    end
end
