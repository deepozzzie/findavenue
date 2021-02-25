class AddRatingCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :rating, :string
  end
end
