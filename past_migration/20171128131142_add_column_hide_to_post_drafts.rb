class AddColumnHideToPostDrafts < ActiveRecord::Migration[5.1]
  def change
    add_column :post_drafts, :hide, :boolean, default: false
  end
end
