class RemoveCategoryAndRegionFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :category, :string
    remove_column :posts, :region, :string
  end
end
