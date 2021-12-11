class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.string :title, default: "Limited Sale on Everything!"
      t.decimal :discount, default: 0.05
      t.date :from, default: -> { "CURRENT_DATE" }
      t.date :till, default: -> { "CURRENT_DATE" }

      t.timestamps
    end
  end
end
