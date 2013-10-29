class AddAppointmentIdToRecordEntry < ActiveRecord::Migration
  def change
    add_column :record_entries, :appointment_id, :integer
  end
end
