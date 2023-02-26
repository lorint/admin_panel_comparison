class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    return unless reverting? || !table_exists?(:orders)

    create_table :orders, id: :serial, primary_key: :id do |t|
      t.date :order_date
      t.references :customer, type: :integer, foreign_key: { to_table: :customers }
      t.references :employee, type: :integer, foreign_key: { to_table: :employees }
      t.date :required_date
      t.date :shipped_date
      t.integer :ship_via_id
      t.decimal :freight
      t.string :ship_name
      t.string :ship_address
      t.string :ship_city
      t.string :ship_region
      t.string :ship_postal_code
      t.string :ship_country
      t.string :customer_code
    end
  end
end
