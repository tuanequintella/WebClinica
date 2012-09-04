class Record < ActiveRecord::Base

  attr_accessible :id, :record_status
  belongs_to :pacient
  has_many :appointments

  I18N_PATH = 'activerecord.attributes.record.'

  def self.statuses
    [I18n.t(I18N_PATH + 'new'), I18n.t(I18N_PATH + 'regular'), I18n.t(I18N_PATH + 'beginner')]
  end

end
