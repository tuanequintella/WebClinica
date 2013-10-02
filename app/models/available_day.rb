class AvailableDay < ActiveRecord::Base
  extend Enumerize

  attr_accessible :day, :work_start_time, :work_end_time, :interval_start_time, :interval_end_time

  belongs_to :agenda
  I18N_PATH = 'activerecord.attributes.available_day.'
  
  enumerize :day, in: {sunday: 0, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6}


end

