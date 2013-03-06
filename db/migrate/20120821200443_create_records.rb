class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :code
      t.string :status
      t.string :description
      t.references :pacient
      t.timestamps
    end
  end
end
