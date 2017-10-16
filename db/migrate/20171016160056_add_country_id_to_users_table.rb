class AddCountryIdToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :country_id, :integer, default: 2
  end
end
