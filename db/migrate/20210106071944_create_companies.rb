class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :lat
      t.string :lng
      t.string :phone_number
      t.string :link
      t.string :capacity

      t.timestamps
    end
  end
end
