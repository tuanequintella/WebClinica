#encoding: utf-8
class RecordEntry < ActiveRecord::Base
  attr_accessor :appointment_attachments_attributes, :from_record
  attr_accessible :diagnosis, :prescription, :problems, :appointment_id, :appointment_attachments_attributes, :from_record
  
  
  belongs_to :appointment
  has_many :appointment_attachments
  accepts_nested_attributes_for :appointment_attachments, allow_destroy: true
end
