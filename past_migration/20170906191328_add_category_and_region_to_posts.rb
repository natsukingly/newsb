class AddCategoryAndRegionToPosts < ActiveRecord::Migration[5.1]
  def self.up
    add_column :posts, :category, :string
    add_column :posts, :region, :string
  end
  
  def self.down
    remove_column :posts, :category
    remove_column :posts, :region
  end
end
