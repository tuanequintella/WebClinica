class CreateAgenda < ActiveRecord::Migration
  def change
    create_table :agendas do |t|
      t.references :doctor
      t.integer :default_meeting_length
      t.boolean :active

      t.timestamps
    end
  end
end
