class AddOpeningHoursToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :monday_open, :integer
    add_column :companies, :monday_closed, :integer
    add_column :companies, :tuesday_open, :integer
    add_column :companies, :tuesday_closed, :integer
    add_column :companies, :wednesday_open, :integer
    add_column :companies, :wednesday_closed, :integer
    add_column :companies, :thursday_open, :integer
    add_column :companies, :thursday_closed, :integer
    add_column :companies, :friday_open, :integer
    add_column :companies, :friday_closed, :integer
    add_column :companies, :saturday_open, :integer
    add_column :companies, :saturday_closed, :integer
    add_column :companies, :sunday_open, :integer
    add_column :companies, :sunday_closed, :integer
  end
end
