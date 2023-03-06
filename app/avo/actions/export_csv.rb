class ExportCsv < Avo::BaseAction
  self.name = "Export CSV"
  self.may_download_file = true

  field :id, as: :boolean
  field :order_date, as: :boolean
  field :required_date, as: :boolean
  field :shipped_date, as: :boolean
  field :ship_city, as: :boolean
  field :ship_country, as: :boolean
  field :ship_region, as: :boolean
  field :ship_address, as: :boolean
  field :ship_postal_code, as: :boolean
  field :ship_name, as: :boolean
  field :freight, as: :boolean
  field :ship_via_id, as: :boolean
  field :customer_code, as: :boolean

  def handle(models:, resource:, fields:, **)
    columns = get_columns_from_fields(fields)

    return error "No record selected" if models.blank?

    file = CSV.generate(headers: true) do |csv|
      csv << columns

      models.each do |record|
        csv << columns.map do |attr|
          record.send(attr)
        end
      end
    end

    download file, "#{resource.plural_name}.csv"
  end

  def get_columns_from_fields(fields)
    fields.select { |key, value| value }.keys
  end
end
