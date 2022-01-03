class RemoveUserIdAndCategoryIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :user_id, :integer
    remove_column :posts, :category_id, :integer
  end
end
