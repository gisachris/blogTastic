class AddReferencesToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :user, foreign_key: {to_table: :users, column: :AuthorId}
    add_reference :likes, :post, foreign_key: true
  end
end
