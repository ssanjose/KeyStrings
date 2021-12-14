class AddTaxesToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :pst, :decimal, null: false
    add_column :orders, :gst, :decimal, null: false
  end
end
