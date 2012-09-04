class AvailableDay < ActiveRecord::Base

  belongs_to :agenda
  I18N_PATH = 'activerecord.attributes.available_day.'

end
