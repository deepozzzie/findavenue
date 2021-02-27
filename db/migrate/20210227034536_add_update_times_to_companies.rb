class AddUpdateTimesToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :update_number, :int, default: 0
  end
end
