module ApplicationHelper

  def datetime_string(date,time)
    "#{date.day}/#{date.month}/#{date.year} #{time.hour}:#{time.min}:#{time.sec}"
  end

  def icon_title_for(title, icon)
    content_for(:content_title) { content_tag(:i, "", class: icon) + " " + title }
  end

  def time_format(datetime)
  	datetime.strftime('%H:%M') unless datetime.blank?
  end

  def date_format(datetime)
    I18n.l(datetime.to_date) unless datetime.blank?
  end
end

