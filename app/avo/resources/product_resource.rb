class ProductResource < Avo::BaseResource
  self.title = :product_name
  self.includes = [:category, :order_details]
  self.description = "Product picture is a random image from https://picsum.photos/ just for the exmaple. Change to grid view to see the cover image."
  self.search_query = -> do
    scope.ransack(product_name_cont: params[:q], m: "or").result(distinct: false)
  end

  field :id, as: :id
  field :product_name, as: :text
  field :category, as: :belongs_to
  field :unit_price, as: :number
  field :discontinued, as: :boolean
  field :units_in_stock, as: :number
  field :units_on_order, as: :number
  field :reorder_level, as: :number
  field :quantity_per_unit, as: :text
  field :supplier_id, as: :number
  field :order_details, as: :has_many

  grid do
    cover :cover_photo, as: :external_image do |category|
      "https://picsum.photos/200"
    rescue
      nil
    end
    title :product_name, as: :text, required: true, link_to_resource: true
    body :description, as: :text do |product|
      "UnitPrice: #{product.unit_price}, Stock: #{product.units_in_stock}"
    end
  end
end
