class Appointment < ActiveRecord::Base
  attr_accessible :record, :agenda, :scheduled_at
  
  belongs_to :record
  belongs_to :agenda

  I18N_PATH = 'activerecord.attributes.appointment.'
  
  def to_s
    self.scheduled_at
  end

end
