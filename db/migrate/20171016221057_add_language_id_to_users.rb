class AddLanguageIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :language_id, :integer, default: 1
  end
end
