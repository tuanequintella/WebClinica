class Appointment < ActiveRecord::Base

  belongs_to :record
  belongs_to :agenda

  I18N_PATH = 'activerecord.attributes.appointment.'

end
