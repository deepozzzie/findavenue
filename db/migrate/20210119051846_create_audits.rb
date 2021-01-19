class CreateAudits < ActiveRecord::Migration[6.1]
  def change
    create_table :audits do |t|
      t.string :venue_name
      t.string :venue_capacity

      t.timestamps
    end
  end
end
