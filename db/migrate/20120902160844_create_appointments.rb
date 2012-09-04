class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :agenda
      t.datetime :date_time
      t.references :record
    end
  end
end
