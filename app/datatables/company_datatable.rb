class CompanyDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Company.id"},
      name: { source: "Company.name", cond: :like, searchable: true, orderable: true },
      address: { source: "Company.address", cond: :like},
      email: { source: "Company.email"},
      phone_number: { source: "Company.phone_number"},
      capacity: { source: "Company.capacity"},
      link: { source: "Company.link"},
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        name: record.name,
        address: record.address,
        email: record.email,
        phone_number: record.phone_number,
        link: record.link,
        capacity: record.capacity,
        DT_RowId:   record.id,
      }
    end
  end

  def get_raw_records
      Company.all
  end

end
