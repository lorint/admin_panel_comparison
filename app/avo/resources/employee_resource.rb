class EmployeeResource < Avo::BaseResource
  self.title = :first_name
  self.includes = []
 
  field :id, as: :id
  field :name, as: :text do |employee|
    "#{employee.title_of_courtesy} #{employee.first_name} #{employee.last_name}"
  end

  with_options as: :text, hide_on: :index do
    field :first_name
    field :last_name
    field :title_of_courtesy
  end

  field :title, as: :text
  field :reports_to, as: :belongs_to
  field :hire_date, as: :date

  heading "Address"
  field :city, as: :text
  field :country, as: :text

  heading "Contact"
  field :home_phone, as: :text
  field :extension, as: :text

  sidebar do
    field :address, as: :text
    field :region, as: :text
    field :postal_code, as: :text
    field :birth_date, as: :date
    field :notes, as: :textarea
  end
    
  field :orders, as: :has_many
  field :employees, as: :has_many
end
