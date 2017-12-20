class ChangeColumnEIndecatorToArticles < ActiveRecord::Migration[5.1]
  def change
    change_column :articles, :e_indecator, :integer, default: 0
  end
end
