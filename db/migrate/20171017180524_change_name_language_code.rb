class ChangeNameLanguageCode < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :languages, :language_code, :code
  end

  def self.down
    # rename back if you need or do something else or do nothing
    rename_column :languages, :code, :language_code
  end
end
