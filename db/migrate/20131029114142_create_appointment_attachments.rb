class CreateAppointmentAttachments < ActiveRecord::Migration
  def change
    create_table :appointment_attachments do |t|
      t.attachment :file
      t.text :notes
      t.references :record_entry
      
      t.timestamps
    end
  end
end
