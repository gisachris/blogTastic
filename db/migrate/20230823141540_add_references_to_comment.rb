class AddReferencesToComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, foreign_key: {to_table: :users, column: :AuthorId}
    add_reference :comments, :posts, foreign_key: true
  end
end
