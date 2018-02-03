class AddColumnKeywordsToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :keywords, :text, array: true
  end
end
