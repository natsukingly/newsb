class ChangeNameLanguages < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :languages, :country_code, :language_code
  end

  def self.down
    # rename back if you need or do something else or do nothing
    rename_column :languages, :language_code, :country_code
  end
end
