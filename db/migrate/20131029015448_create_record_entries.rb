class CreateRecordEntries < ActiveRecord::Migration
  def change
    create_table :record_entries do |t|
      t.text :problems
      t.text :diagnosis
      t.text :prescription

      t.timestamps
    end
  end
end
