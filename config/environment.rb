# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
WebClinica::Application.initialize!

Time::DATE_FORMATS.merge!(
  :default => '%d/%m/%Y %H:%M',
  :date_default  => "%d/%m/%Y",
  :db => '%Y-%m-%d %H:%M:%S',
  :full12  => "%d/%m/%Y %I:%M%p",
  :full24  => "%d/%m/%Y %H:%M",
  :simple  => "%d/%m %H:%M",
  :js  => "%d de %B de %Y - %H:%M",
  :small  => "%B %d, %Y",
)
