class AddLanguageIdToCountries < ActiveRecord::Migration[5.1]
  def change
    add_column :countries, :language_id, :integer
  end
end
