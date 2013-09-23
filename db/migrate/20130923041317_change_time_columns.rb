class ChangeTimeColumns < ActiveRecord::Migration
  def up
    change_column :available_days, :work_start_time, :time
    change_column :available_days, :work_end_time, :time
    change_column :available_days, :interval_start_time, :time
    change_column :available_days, :interval_end_time, :time
  end

  def down
    change_column :available_days, :work_start_time, :datetime
    change_column :available_days, :work_end_time, :datetime
    change_column :available_days, :interval_start_time, :datetime
    change_column :available_days, :interval_end_time, :datetime
  end
end
