class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    return unless reverting? || !table_exists?(:categories)

    create_table :categories, id: :serial, primary_key: :id do |t|
      t.string :category_name
      t.string :description
      t.binary :picture
    end
  end
end
