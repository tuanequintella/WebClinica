class RenameTimeColumns < ActiveRecord::Migration
  def up
    rename_column :available_days, :work_start_time, :work_start_t
    rename_column :available_days, :work_end_time, :work_end_t
    rename_column :available_days, :interval_start_time, :interval_start_t
    rename_column :available_days, :interval_end_time, :interval_end_t
  end

  def down
    rename_column :available_days, :work_start_t, :work_start_time
    rename_column :available_days, :work_end_t, :work_end_time
    rename_column :available_days, :interval_start_t, :interval_start_time
    rename_column :available_days, :interval_end_t, :interval_end_time
  end
end
