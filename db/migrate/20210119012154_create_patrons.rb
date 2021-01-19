class CreatePatrons < ActiveRecord::Migration[6.1]
  def change
    create_table :patrons do |t|
      t.string :first_name
      t.string :phone_number
      t.boolean :waitlist, default: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
