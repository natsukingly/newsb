class AddColumnNameToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :name, :string
  end
end
