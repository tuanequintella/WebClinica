class AppointmentAttachment < ActiveRecord::Base
  attr_accessible :file, :notes

  has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/assets/images/attachment.png"

  validates_attachment :file, :size => { :in => 0..5.megabytes }
end
