class ChnageColumnShoulderNameOnUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :credential, :string
    add_column :users, :credential, :string
  end

  def down
    add_column :users, :credential, :string
    remove_column :users, :credential, :string
  end
end
