class CreateVenues < ActiveRecord::Migration[6.1]
  def change
    create_table :venues do |t|
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
