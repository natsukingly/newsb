class AddCountryIdToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :country_id, :integer
  end
end
