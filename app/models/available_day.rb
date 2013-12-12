class AvailableDay < ActiveRecord::Base
  extend Enumerize

  attr_accessible :day, :work_start_t, :work_end_t, :interval_start_t, :interval_end_t
  belongs_to :agenda
  
  enumerize :day, in: {sunday: 0, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6}

  validates_uniqueness_of :day, scope: :agenda_id, message: "Dia da semana já definido para essa agenda"
  validates_presence_of :day, :work_start_t, :work_end_t
  validates_time :work_start_t, :work_end_t
  validates_time :interval_start_t, :after => :work_start_t, allow_blank: true
  validates_time :interval_end_t, :after => :interval_start_t, :before => :work_end_t, allow_blank: true
  validates_time :work_end_t, :after => :work_start_t
  validates_time :work_end_t, :after => :interval_end_t, unless: lambda { self.interval_end_t.blank? }


  validates_associated :agenda

  I18N_PATH = 'activerecord.attributes.available_day.'

  def work_start_time
    work_start_t.localtime unless work_start_t.blank?
  end

  def interval_start_time
    interval_start_t.localtime unless interval_start_t.blank?
  end
  
  def interval_end_time
    interval_end_t.localtime unless interval_end_t.blank?
  end

  def work_end_time
    work_end_t.localtime unless work_end_t.blank?
  end

end

