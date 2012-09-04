class CreateAgenda < ActiveRecord::Migration
  def change
    create_table :agendas do |t|
      t.references :doctor
      t.string :default_meeting_length

      t.timestamps
    end
  end
end
