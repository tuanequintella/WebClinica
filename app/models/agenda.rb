class Agenda < ActiveRecord::Base
  attr_accessor :available_days_attributes
  attr_accessible :default_meeting_length, :available_days_attributes

  I18N_PATH = 'activerecord.attributes.agenda.'

  belongs_to :doctor
  has_many :available_days
  has_many :appointments

  accepts_nested_attributes_for :available_days

  def week (string_date)
    date_array = string_date.split('-').map(&:to_i)
    date = Date.new(date_array[0],date_array[1],date_array[2])

    (date.beginning_of_week...date.end_of_week).to_a
  end

  def time_array(week)
    d = [available_days.all.map(&:work_start_time).map(&:hour).min]
    d << available_days.all.map(&:work_end_time).map(&:hour).max
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

end

