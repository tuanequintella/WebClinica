class Appointment < ActiveRecord::Base
  attr_accessible :record, :agenda, :scheduled_at, :agenda_id, :record_id
  
  belongs_to :record
  belongs_to :agenda

  I18N_PATH = 'activerecord.attributes.appointment.'
  
  after_save :increase_records_last_appointment
  before_destroy :decrease_records_last_appointment

  def to_s
    self.scheduled_at
  end

  def increase_records_last_appointment
    dates = record.appointments.map(&:scheduled_at)
    if dates.max <= scheduled_at
      record.last_appointment = self
      record.save
    end
  end

  def decrease_records_last_appointment
    remaining_apps = record.appointments.reject{ |e| e == self }.sort_by{ |ap| ap.scheduled_at }
    record.last_appointment = remaining_apps.last
    record.save
  end

end
