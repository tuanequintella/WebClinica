class AddHealthInsuranceToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :health_insurance_id, :integer
  end
end
