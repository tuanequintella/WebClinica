module AppointmentsHelper
  def today_appointments(doctor)
    doctor.agenda.appointments.select{ |ap| ap.scheduled_at.to_date == Date.today }
  end

  def icon_for_status(status)
    case status
    when 'pending'
      image_tag('appointment_pending.png', width: '20px', height: '20px', style: 'padding-right: 5px')
    when 'pacient_arrived'
      image_tag('pacient_arrived.png', width: '20px', height: '20px', style: 'padding-right: 5px')
    when 'on_going'
      image_tag('appointment_ongoing.png', width: '20px', height: '20px', style: 'padding-right: 5px')
    when 'finished'
      image_tag('appointment_finished.png', width: '20px', height: '20px', style: 'padding-right: 5px')
    when 'pacient_absent'
      image_tag('pacient_absent.png', width: '20px', height: '20px', style: 'padding-right: 5px')
    else
      "alo"
    end
  end
end