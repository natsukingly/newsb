class EditArticlesForCategoryAndRegion < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :category, :string
    remove_column :articles, :region, :string
    
    add_column :articles, :category_id, :integer
    add_column :posts, :category_id, :integer
  end
end
