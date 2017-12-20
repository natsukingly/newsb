class AddCountryIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :country_id, :integer
  end
end
