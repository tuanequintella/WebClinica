class Agenda < ActiveRecord::Base
  attr_accessor :available_days_attributes
  attr_accessible :default_meeting_length, :available_days_attributes, :active

  I18N_PATH = 'activerecord.attributes.agenda.'

  belongs_to :doctor
  has_many :available_days
  has_many :appointments

  accepts_nested_attributes_for :available_days

  def deactivate!
    self.active = false
  end

  def activate!
    self.active = true
  end

  def week (string_date)
    date = string_date.to_date

    (date.beginning_of_week...date.end_of_week).to_a
  end

  def time_array(week)
    d = [available_days.pluck(:work_start_time).map(&:hour).min]
    d << available_days.pluck(:work_end_time).map(&:hour).max
    week.each do |day|
      d += appointments_for_day(day).map(&:date_time).map(&:hour)
    end

    start_of_shift = Date.today.beginning_of_day + d.min.hours
    end_of_shift = Date.today.beginning_of_day + (d.max + 1).hours

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
    nil
  end

  def appointments_for_day(day)
    self.appointments.all.select do |a|
      a.date_time.to_date == day
    end
  end

  def self.some_days
    date = Date.today

    (date.beginning_of_month...date.end_of_month).to_a
  end

  def to_s
    id
  end

  def time_in_milis(time)
    return Time.at(time.hour * 60 * 60 + time.min * 60 + time.sec)
  end

end

