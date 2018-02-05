class AddColumnCategoryLockToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :category_lock, :boolean, default: false
  end
end
