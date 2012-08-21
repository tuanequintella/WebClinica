class CreateRecord < ActiveRecord::Migration
  def change
    create_table :record do |t|
      t.string :record_id
      t.string :record_status
      t.string :description
      t.timestamps
    end
  end
end
