class RemoveColumnJaNameFromCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :ja_name
  end
end
