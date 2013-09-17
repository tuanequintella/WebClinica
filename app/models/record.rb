#encoding: utf-8
class Record < ActiveRecord::Base
  extend Enumerize

  attr_accessible :status, :description, :pacient, :last_appointment
  belongs_to :last_appointment, :foreign_key => "last_appointment_id", :class_name => "Appointment"
  belongs_to :pacient
  has_many :appointments
  #has_many :record_entries, through: :appointments

  enumerize :status, in: [:inactive, :new, :regular, :beginner], default: :new
  
  validates_presence_of :status
  
  I18N_PATH = 'activerecord.attributes.record.'

  def deactivate!
    status = :inactive
    save
  end
  
  def activate!
    status = :regular
    save
  end
  
  def active?
    !(status.inactive?)
  end
  
  def to_s
    "%04d" % self.id
  end
  
  def as_json (options = {})
    super(:include => [:last_appointment, :pacient])
  end

end

