class OrderDetailResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :order, as: :belongs_to
  field :product, as: :belongs_to
  field :unit_price, as: :number
  field :quantity, as: :number
  field :discount, as: :number
  # add fields here
end
