class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :title
      t.decimal :pst
      t.decimal :gst

      t.timestamps
    end
  end
end
