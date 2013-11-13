class Agenda < ActiveRecord::Base
  attr_accessor :available_days_attributes
  attr_accessible :default_meeting_length, :available_days_attributes, :active

  I18N_PATH = 'activerecord.attributes.agenda.'

  belongs_to :doctor
  has_many :available_days
  validate :available_days_amount
  has_many :appointments

  accepts_nested_attributes_for :available_days

  scope :active, where(active: true)

  def available_days_amount
    errors.add(:base, "Máximo de 7 dias da semana") if available_days.length > 7
    errors.add(:base, "Dia da semana duplicado") if available_days.map(&:day).uniq != available_days.map(&:day)
  end

  def deactivate!
    if appointments.select{|app| app.scheduled_at > Time.now}.any?
      return false
    end
    self.active = false
    self.save
  end

  def activate!
    self.active = true
    self.save
  end

  def doctor_name
    doctor.name
  end

  def week (string_date)
    date = string_date.to_date

    (date.beginning_of_week...date.end_of_week).to_a
  end

  def time_array(week)
    d = [available_days.map(&:work_start_time).min]
    d << available_days.map(&:work_end_time).max
    week.each do |day|
     # d += appointments_for_day(day).map(&:scheduled_at).map(&:to_time)
     #TODO: pegar só o horário da consulta, e não data e hora, senão a consulta sempre será o max_value do array
    end

    start_of_shift = Date.today.beginning_of_day + d.min.hour.hours + d.min.min.minutes - (default_meeting_length).minutes
    end_of_shift = Date.today.beginning_of_day + d.max.hour.hours + d.max.min.minutes + (2 * default_meeting_length).minutes

    time_array = []

    time = start_of_shift
    while time < end_of_shift
      time_array.push time
      time+=(default_meeting_length.minutes)
    end

    time_array
  end

  def available_datetime? (datetime)
    week_day = available_days.where(:day => datetime.wday).first

    if not(week_day.nil?)
      start_time = time_in_milis(week_day.work_start_time)
      end_time = time_in_milis(week_day.work_end_time)
      interval_start = time_in_milis(week_day.interval_start_time)
      interval_end = time_in_milis(week_day.interval_end_time)
      time = time_in_milis(datetime)

      return ( time.between?(start_time, end_time) && not(time.between?(interval_start, interval_end)) )
    else
      return false
    end
  end

  def appointment_at(datetime)
    self.appointments.where(:scheduled_at => datetime).first
  end

  def appointments_for_day(day)
    self.appointments.all.select do |a|
      a.scheduled_at.to_date == day
    end
  end

  def to_s
    id
  end

  def time_in_milis(time)
    return Time.at(time.hour * 60 * 60 + time.min * 60 + time.sec)
  end

end

