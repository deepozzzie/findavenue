class AddPlacesIdToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :places_id, :string
  end
end
