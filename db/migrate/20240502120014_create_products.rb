class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :quantity, null: false, default: 0 
      t.decimal :unit_price, precision: 17, scale: 2, default: 0.0
      t.decimal :total_price, precision: 17, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
