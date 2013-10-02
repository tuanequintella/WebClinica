class AvailableDay < ActiveRecord::Base
  extend Enumerize

  attr_accessible :day, :work_start_time, :work_end_time, :interval_start_time, :interval_end_time
  belongs_to :agenda
  
  enumerize :day, in: {sunday: 0, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6}

  validates_uniqueness_of :day, scope: :agenda_id, message: "Dia da semana já definido para essa agenda"
  validates_presence_of :day, :work_start_time, :work_end_time
  validates_time :work_start_time, :work_end_time
  validates_time :interval_start_time, :after => :work_start_time
  validates_time :interval_end_time, :after => :interval_start_time, :before => :work_end_time
  validates_time :work_end_time, :after => :interval_end_time

  I18N_PATH = 'activerecord.attributes.available_day.'

end

