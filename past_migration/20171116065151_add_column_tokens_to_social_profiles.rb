class AddColumnTokensToSocialProfiles < ActiveRecord::Migration[5.1]
  def up
    add_column :social_profiles, :access_token, :string
    add_column :social_profiles, :access_secret, :string
  end

  def down
    remove_column :social_profiles, :access_token, :string
    remove_column :social_profiles, :access_secret, :string
  end
end
