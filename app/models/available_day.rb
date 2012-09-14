class AvailableDay < ActiveRecord::Base

  attr_accessible :day, :work_start_time, :work_end_time, :interval_start_time, :interval_end_time

  belongs_to :agenda
  I18N_PATH = 'activerecord.attributes.available_day.'

  def self.days
    [[I18n.t(I18N_PATH + 'sunday'), 1], [I18n.t(I18N_PATH + 'monday'), 2], [I18n.t(I18N_PATH + 'tuesday'), 3], [I18n.t(I18N_PATH + 'wednesday'), 4], [I18n.t(I18N_PATH + 'thursday'), 5], [I18n.t(I18N_PATH + 'friday'), 6], [I18n.t(I18N_PATH + 'saturday'), 7]]
  end

end

