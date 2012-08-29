class RemoveRecordFromPacient < ActiveRecord::Migration
  def change
    remove_column :pacients, :record_id
    remove_column :pacients, :record_status
  end
end
