class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.string :title, default: "No sale for this week!"
      t.decimal :discount, default: 0.00
      t.date :from, default: -> { "CURRENT_DATE" }
      t.date :till, default: -> { "CURRENT_DATE" }

      t.timestamps
    end
  end
end
