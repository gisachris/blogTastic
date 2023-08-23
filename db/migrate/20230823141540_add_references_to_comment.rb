class AddReferencesToComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, foreign_key: {to_table: :users, column: :author_id}
    add_reference :comments, :posts, foreign_key: true

    add_index :comments, :author_id
    add_index :comments, :post_id
  end
end
