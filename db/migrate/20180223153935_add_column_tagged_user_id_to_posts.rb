class AddColumnTaggedUserIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :tagged_user_id, :integer
  end
end
