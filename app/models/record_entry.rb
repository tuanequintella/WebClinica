#encoding: utf-8
class RecordEntry < ActiveRecord::Base
  attr_accessor :appointment_attachments_attributes, :from_record
  attr_accessible :diagnosis, :prescription, :problems, :appointment_id, :appointment_attachments_attributes, :from_record, :cid, :cid_id
  
  belongs_to :cid
  belongs_to :appointment
  has_many :appointment_attachments
  accepts_nested_attributes_for :appointment_attachments, allow_destroy: true

  validates_presence_of :cid

  def self.params_search(params)
    entries = RecordEntry.where(cid_id: params[:cid_id]).all
    entries = entries.select{|entry| entry.appointment.scheduled_at.to_date >= params[:date_from].to_date && entry.appointment.scheduled_at.to_date <= params[:date_to].to_date}
    entries.uniq
  end
end
