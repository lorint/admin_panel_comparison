class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    return unless reverting? || !table_exists?(:customers)

    create_table :customers, id: :serial, primary_key: :id do |t|
      t.string :company_code
      t.string :company_name
      t.string :contact_name
      t.string :contact_title
      t.string :address
      t.string :city
      t.string :region
      t.string :postal_code
      t.string :country
      t.string :phone
      t.string :fax
    end
  end
end
