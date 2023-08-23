class AddReferencesToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :user, foreign_key: {to_table: :users, column: :author_id}
    add_reference :likes, :post, foreign_key: true

    add_index :likes, :author_id
    add_index :likes, :post_id
  end
end
