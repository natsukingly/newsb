class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :image
      t.string :url
      t.string :source
      t.datetime :published_time

      t.timestamps
    end
  end
end
