class AddShoulderNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :credential, :string, default: "Newspartyの村人X"
  end
end
