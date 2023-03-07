class CategoryResource < Avo::BaseResource
  self.title = :category_name
  self.includes = [:products]
  self.record_selector = false
  self.description = "Category picture is a random image from https://picsum.photos/ just for the exmaple."

  field :category_name, as: :text
  field :description, as: :trix, always_show: true
  field :description_excerpt, as: :text, only_on: :index do |category|
    ActionView::Base.full_sanitizer.sanitize(category.description).truncate 120
  end
  field :picture, as: :external_image do |category|
    "https://picsum.photos/400"
  rescue
    nil
  end
  field :products, as: :has_many, discreet_pagination: true, searchable: true
  field :product_count, as: :number, only_on: :index do |category|
    category.products.count
  end
end
