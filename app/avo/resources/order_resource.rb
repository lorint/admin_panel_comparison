class OrderResource < Avo::BaseResource
  self.title = :id

  field :id, as: :id
  field :customer, as: :has_one
  field :employee, as: :belongs_to

  with_options as: :date, sortable: true do
    heading "Dates"
    field :order_date
    field :required_date
    field :shipped_date
  end

  field :ship_location, as: :text, only_on: :index do |order|
    "#{order.ship_city}, #{order.ship_country}"
  end

  with_options as: :text, hide_on: :index do
    heading "Address"
    field :ship_city, as: :text
    field :ship_country, as: :text
    field :ship_region, as: :text
    field :ship_address, as: :text
    field :ship_postal_code, as: :text
  end

  sidebar do 
    heading "Shipping"
    field :ship_name, as: :text
    field :freight, as: :number
    field :ship_via_id, as: :number
    field :customer_code, as: :text
  end

  field :order_details, as: :has_many

  action ExportCsv
end
