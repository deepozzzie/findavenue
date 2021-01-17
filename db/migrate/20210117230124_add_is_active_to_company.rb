class AddIsActiveToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :is_active, :boolean, :default => false
  end
end
