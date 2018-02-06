class ChangeColumnPriorityLevelToArticles < ActiveRecord::Migration[5.1]
  def change
    change_column :articles, :priority_level, :integer, default: 10
  end
end
