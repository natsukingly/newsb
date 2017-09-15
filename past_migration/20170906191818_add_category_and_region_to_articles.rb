class AddCategoryAndRegionToArticles < ActiveRecord::Migration[5.1]
  def self.up
    add_column :articles, :category, :string
    add_column :articles, :region, :string
  end
  
  def self.down
    remove_column :articles, :category
    remove_column :articles, :region
  end
end
