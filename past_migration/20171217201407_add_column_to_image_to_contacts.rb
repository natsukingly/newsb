class AddColumnToImageToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :image, :string
  end
end
