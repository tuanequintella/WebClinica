#encoding: utf-8
class Record < ActiveRecord::Base

  attr_accessible :status, :description, :pacient, :last_appointment
  belongs_to :last_appointment, :foreign_key => "last_appointment_id", :class_name => "Appointment"
  belongs_to :pacient
  has_many :appointments
  
  INACTIVE = "Inativo"
  NEW = "Nova ficha"
  REGULAR = "Regular"
  BEGINNER = "Primeiras vezes"
  TEMP = "Temporária"
  
  validates_presence_of :status
  
  I18N_PATH = 'activerecord.attributes.record.'

  def self.status
    [[NEW, NEW], [REGULAR, REGULAR], [BEGINNER, BEGINNER], [TEMP, TEMP], [INACTIVE, INACTIVE]]
  end
  
  def deactivate!
    self.status = INACTIVE
  end
  
  def activate!
    self.status = REGULAR
  end
  
  def active?
    unless self.status == INACTIVE
      true
    else
      false
    end
  end
  
  def method_name
    
  end
  
  def to_s
    "%04d" % self.id
  end
  
  def as_json (options = {})
    super(:include => [:last_appointment, :pacient])
  end

end

