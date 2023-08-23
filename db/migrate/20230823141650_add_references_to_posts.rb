class AddReferencesToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, foreign_key: {to_table: :users, column: :AuthorId}
  end
end
