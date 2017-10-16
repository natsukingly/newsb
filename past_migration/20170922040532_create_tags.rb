class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :post_count, default: 0

      t.timestamps
    end
  end
end
