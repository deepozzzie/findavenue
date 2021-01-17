class AddPercentageFullToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :percentage_full, :float
  end
end
