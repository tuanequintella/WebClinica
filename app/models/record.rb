class Record < ActiveRecord::Base

  attr_accessible :status, :description, :pacient, :last_appointment
  belongs_to :last_appointment, :foreign_key => "last_appointment_id", :class_name => "Appointment"
  belongs_to :pacient
  has_many :appointments
  
  INACTIVE = "inactive"
  NEW = "new"
  REGULAR = "regular"
  BEGINNER = "beginner"
  #TODO: novo status TEMP para novos pacientes a partir de um agendamento de consulta
  
  
  I18N_PATH = 'activerecord.attributes.record.'

  def self.status
    [[I18n.t(I18N_PATH + NEW), NEW], [I18n.t(I18N_PATH + REGULAR), REGULAR], [I18n.t(I18N_PATH + BEGINNER), BEGINNER], [I18n.t(I18N_PATH + INACTIVE), INACTIVE]]
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

  def to_s
    "%04d" % self.id
  end
  
  def as_json (options)
    options[:include] = :pacient
    super(options)
  end

end

