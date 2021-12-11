class CreateOrderHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :order_histories do |t|
      t.integer :quantity, null: false, default: 1
      t.decimal :price, null: false
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
