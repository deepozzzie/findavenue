class AddIsOpenToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :is_open, :boolean
  end
end
