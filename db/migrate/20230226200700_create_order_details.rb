class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    return unless reverting? || !table_exists?(:order_details) ||
                  ActiveRecord::Base.connection.current_database == 'northwind'

    create_table :order_details, id: :serial, primary_key: :id do |t|
      t.decimal :unit_price
      t.integer :quantity
      t.decimal :discount
      t.references :order, type: :integer, foreign_key: { to_table: :orders }
      t.references :product, type: :integer, foreign_key: { to_table: :products }
    end
  end
end
