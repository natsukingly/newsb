class AddColumnCheckToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :check, :boolean, default: false
  end
end
