class CreateAutoPostRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :auto_post_records do |t|
      t.string :site_name

      t.timestamps
    end
  end
end
