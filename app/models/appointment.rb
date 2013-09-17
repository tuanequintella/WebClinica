class Appointment < ActiveRecord::Base
  extend Enumerize

  attr_accessible :record, :agenda, :scheduled_at, :agenda_id, :record_id, :status
  
  belongs_to :record
  belongs_to :agenda

  enumerize :status, in: [:pending, :pacient_arrived, :on_going, :finished, :pacient_absent], default: :pending

  #has_one :record_entry

  I18N_PATH = 'activerecord.attributes.appointment.'
  
  after_save :increase_records_last_appointment
  before_destroy :decrease_records_last_appointment

  def to_s
    self.scheduled_at
  end

  def increase_records_last_appointment
    if changes[:scheduled_at]
      dates = record.appointments.map(&:scheduled_at)
      record.last_appointment = record.appointments.find{|a| a.scheduled_at == dates.max}
      record.save
    end
  end

  def decrease_records_last_appointment
    remaining_apps = record.appointments.reject{ |e| e == self }.sort_by{ |ap| ap.scheduled_at }
    record.last_appointment = remaining_apps.last
    record.save
  end

end
