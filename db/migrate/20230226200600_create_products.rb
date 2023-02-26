class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    return unless reverting? || !table_exists?(:products)

    create_table :products, id: :serial, primary_key: :id do |t|
      t.string :product_name
      t.references :category, type: :integer, foreign_key: { to_table: :categories }
      t.decimal :unit_price
      t.boolean :discontinued
      t.integer :units_in_stock
      t.integer :units_on_order
      t.integer :reorder_level
      t.string :quantity_per_unit
      t.integer :supplier_id
    end
  end
end
