class CategoryResource < Avo::BaseResource
  self.title = :category_name
  self.includes = [:products]
  self.record_selector = false
  self.description = "Category picture is rendered from binary data stored in the database."

  field :category_name, as: :text
  field :description, as: :trix, always_show: true
  field :description_excerpt, as: :text, only_on: :index do |category|
    ActionView::Base.full_sanitizer.sanitize(category.description).truncate 120
  end
  field :picture, as: :text do |category|
    # Have Brick create an <img> element using inline Base64 when there is a picture available
    ::Brick::Rails.display_binary(category.picture).html_safe
  rescue
    nil
  end
  field :products, as: :has_many, discreet_pagination: true, searchable: true
  field :product_count, as: :number, only_on: :index do |category|
    category.products.count
  end
end
