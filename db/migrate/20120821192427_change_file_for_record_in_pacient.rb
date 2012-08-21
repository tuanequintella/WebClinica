class ChangeFileForRecordInPacient < ActiveRecord::Migration
  def change
    add_column :pacients, :record_id, :integer
    add_column :pacients, :record_status, :string
    remove_column :pacients, :file_id
    remove_column :pacients, :file_status
  end
end
