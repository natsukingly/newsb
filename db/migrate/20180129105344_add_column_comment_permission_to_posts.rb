class AddColumnCommentPermissionToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :comment_permission, :boolean, default: :true
  end
end
