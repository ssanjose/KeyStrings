class AddTaxesToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :taxes, :decimal, null: false
  end
end
