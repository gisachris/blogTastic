class AddReferencesToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :author, foreign_key: {to_table: :users}
    add_reference :likes, :post, foreign_key: true
  end
end
