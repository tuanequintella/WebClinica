module ApplicationHelper

  def datetime_string(date,time)
    "#{date.day}/#{date.month}/#{date.year} #{time.hour}:#{time.min}:#{time.sec}"
  end
end

