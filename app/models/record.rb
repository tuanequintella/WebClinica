class Record < ActiveRecord::Base

  I18N_PATH = 'activerecord.attributes.record.'

  def self.statuses
    [I18n.t(I18N_PATH + 'new'), I18n.t(I18N_PATH + 'regular'), I18n.t(I18N_PATH + 'beginner')]
  end

end
