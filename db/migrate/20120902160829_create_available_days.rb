class CreateAvailableDays < ActiveRecord::Migration
  def change
    create_table :available_days do |t|
        t.references :agenda
        t.integer :day
        t.time :work_start_time
        t.time :work_end_time
        t.time :interval_start_time
        t.time :interval_end_time

        t.timestamps
    end
  end
end
