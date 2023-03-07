class CustomerResource < Avo::BaseResource
  self.title = :company_name
  self.includes = []
  self.search_query = -> do
    scope.ransack(company_name_cont: params[:q], m: "or").result(distinct: false)
  end

  field :id, as: :id
  field :company_code, as: :badge

  with_options as: :text do
    field :company_name
    field :city
    
    with_options as: :text, only_on: :index do
      field :country
      field :contact_name do |customer|
        "#{customer.contact_name} (#{customer.contact_title})"
      end
      field :phone
    end
  end


  heading "Address"
  with_options as: :text, hide_on: :index do
    field :address
    field :region
    field :postal_code
    field :country
  end

  sidebar do
    heading "Contact"
    field :contact_name, as: :text
    field :contact_title, as: :text
    
    field :phone, as: :text
    field :fax, as: :text
  end
 
  field :orders, as: :has_many

  field :search_result, as: :text, as_description: true, hide_on: :all do |customer|
    "#{customer.company_code} (#{customer.city})"
  end
end
