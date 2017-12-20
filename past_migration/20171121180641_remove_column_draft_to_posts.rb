class RemoveColumnDraftToPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :draft, :boolean
  end
end
