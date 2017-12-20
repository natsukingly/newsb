class AddColumnCountryCodeToCountries < ActiveRecord::Migration[5.1]
  def change
    add_column :countries, :code, :string
  end
end
