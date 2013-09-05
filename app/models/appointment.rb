class Appointment < ActiveRecord::Base
  attr_accessible :record, :agenda, :scheduled_at, :agenda_id, :record_id
  
  belongs_to :record
  belongs_to :agenda

  I18N_PATH = 'activerecord.attributes.appointment.'
  
  after_save :update_records_last_appointment

  def to_s
    self.scheduled_at
  end

  def update_records_last_appointment
    binding.pry
    dates = record.appointments.map(&:scheduled_at)
    if dates.max <= scheduled_at
      record.last_appointment = self
      record.save
    end
  end

end
