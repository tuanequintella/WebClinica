class Agenda < ActiveRecord::Base

  I18N_PATH = 'activerecord.attributes.agenda.'

  has_many :available_days
  has_many :appointments

end
