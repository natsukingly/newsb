class AddCountryIdToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :country_id, :integer
  end
end
