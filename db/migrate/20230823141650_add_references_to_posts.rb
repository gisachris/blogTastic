class AddReferencesToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, foreign_key: {to_table: :users, column: :author_id}

    add_index :posts, :author_id
  end
end
