class CreateAvailableDays < ActiveRecord::Migration
  def change
    create_table :available_days do |t|
        t.references :agenda
        t.integer :day
        t.datetime :work_start_time
        t.datetime :work_end_time
        t.datetime :interval_start_time
        t.datetime :interval_end_time

        t.timestamps
    end
  end
end
