class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.boolean :running, null: false, default: true
      t.date :created, null: false, default: -> { "CURRENT_DATE" }
      t.decimal :price, null: false
      t.references :user, null: false, foreign_key: true
      t.references :discount, null: true, foreign_key: true

      t.timestamps
    end
  end
end
