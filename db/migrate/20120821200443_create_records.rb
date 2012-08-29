class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :record_id
      t.string :record_status
      t.string :description
      t.references :pacient
      t.timestamps
    end
  end
end
