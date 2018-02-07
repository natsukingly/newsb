class AddColumnSharedArticlesCountToAutoPostRecord < ActiveRecord::Migration[5.1]
  def change
     add_column :auto_post_records, :shared, :integer
  end
end
