class AddColumnPriorityLevelToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :priority_level, :integer, default: 0
  end
end
