class AddEmailToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :email, :string
  end
end
