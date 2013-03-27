class AddLastAppointmentToRecord < ActiveRecord::Migration
  def change
    add_column :records, :last_appointment_id, :integer
  end
end
