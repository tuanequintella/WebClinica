module AppointmentsHelper
  def today_appointments(doctor)
    doctor.agenda.appointments.select{ |ap| ap.scheduled_at.to_date == Date.today }
  end
end