class Notification < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :target_user, class_name: 'User', foreign_key: 'target_user_id', optional: true
end
