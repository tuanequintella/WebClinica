class AvailableDay < ActiveRecord::Base

  attr_accessible :day, :work_start_time, :work_end_time, :interval_start_time, :interval_end_time

  belongs_to :agenda
  I18N_PATH = 'activerecord.attributes.available_day.'

  def self.days
    [[I18n.t(I18N_PATH + 'sunday'), 0], [I18n.t(I18N_PATH + 'monday'), 1], [I18n.t(I18N_PATH + 'tuesday'), 2], [I18n.t(I18N_PATH + 'wednesday'), 3], [I18n.t(I18N_PATH + 'thursday'), 4], [I18n.t(I18N_PATH + 'friday'), 5], [I18n.t(I18N_PATH + 'saturday'), 6]]
  end

end

