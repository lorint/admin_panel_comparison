class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    return unless reverting? || !table_exists?(:employees)

    create_table :employees, id: :serial, primary_key: :id do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :title_of_courtesy
      t.references :reports_to, type: :integer
      t.date :birth_date
      t.date :hire_date
      t.binary :photo
      t.string :address
      t.string :city
      t.string :region
      t.string :postal_code
      t.string :country
      t.string :home_phone
      t.string :extension
      t.text :notes
    end
  end
end
