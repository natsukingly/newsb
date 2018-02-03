class ChangeColumnTypeForKeywordsToArticles < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :keywords
    add_column :articles, :keywords, :string
  end
end
