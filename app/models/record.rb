class Record < ActiveRecord::Base

  I18N_PATH = 'activerecord.attributes.record.'
  last_record = 0

  def self.statuses
    [I18n.t(I18N_PATH + 'new'), I18n.t(I18N_PATH + 'regular'), I18n.t(I18N_PATH + 'beginner')]
  end

#  def self.last_record
#    self.last_record++
#    "F" + self.last_record
#  end

end
