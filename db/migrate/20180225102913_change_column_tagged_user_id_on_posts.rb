class ChangeColumnTaggedUserIdOnPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :tagged_user_id, :integer
    add_column :posts, :tagged_user_ids, :string, array: true, default: []
  end
end
