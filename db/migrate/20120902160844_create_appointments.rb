class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :agenda
      t.datetime :scheduled_at
      t.references :record
    end
  end
end
