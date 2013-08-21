module ApplicationHelper

  def datetime_string(date,time)
    "#{date.day}/#{date.month}/#{date.year} #{time.hour}:#{time.min}:#{time.sec}"
  end

  def icon_title_for(title, icon)
    content_for(:content_title) { content_tag(:i, "", class: icon) + " " + title }
  end
end

