class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.integer :customer_id, null: false, foreign_key: true
      t.integer :item_id, null: false, foreign_key: true
      t.integer :amount, null: false
      t.timestamps
    end
  end
end
