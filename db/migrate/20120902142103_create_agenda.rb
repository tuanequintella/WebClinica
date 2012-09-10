class CreateAgenda < ActiveRecord::Migration
  def change
    create_table :agendas do |t|
      t.references :doctor
      t.integer :default_meeting_length

      t.timestamps
    end
  end
end
