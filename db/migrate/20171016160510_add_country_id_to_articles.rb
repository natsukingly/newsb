class AddCountryIdToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :country_id, :integer
  end
end
