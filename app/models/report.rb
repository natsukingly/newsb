class Report < ApplicationRecord
    
    belongs_to :reportable, polymorphic: true
    belongs_to :user
    belongs_to :country
end
