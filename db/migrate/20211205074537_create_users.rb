class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :password
      t.integer :phone
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
