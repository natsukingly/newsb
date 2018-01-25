class AddColumnJaNameToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :ja_name, :string
  end
end
