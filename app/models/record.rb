#encoding: utf-8
class Record < ActiveRecord::Base
  extend Enumerize

  attr_accessible :status, :description, :pacient, :code, :last_appointment_date
  attr_accessor :record_entries_attributes, :last_appointment_date, :health_insurances_options

  belongs_to :pacient
  has_many :appointments
  has_many :record_entries, through: :appointments

  enumerize :status, in: [:inactive, :new, :regular, :beginner], default: :new
  accepts_nested_attributes_for :record_entries, :allow_destroy => false
  validates_presence_of :status
  validates_presence_of :code, on: :create, if: lambda { self.status.regular? }
  validates_presence_of :last_appointment_date, on: :create, unless: lambda { self.status.new? }
  
  I18N_PATH = 'activerecord.attributes.record.'

  def last_appointment
    appointments.with_status(:finished).order("scheduled_at DESC").first
  end

  def parse_health_insurances_options(doctor_id)
    doctor = Doctor.find(doctor_id)
    intersec = [self.pacient.health_insurance] & doctor.health_insurances
    intersec = intersec + [(HealthInsurance.where(name: "Sem convênio (particular)").first)]
    self.health_insurances_options = Hash[intersec.map{|h| [h.id, h.name]}] 
  end

  def deactivate!
    if appointments.select{|app| app.scheduled_at > Time.now}.any?
      return false
    end
    self.status = :inactive
    self.save
  end
  
  def activate!
    self.status = :regular
    self.save
  end
  
  def active?
    !(self.status.inactive?)
  end
  
  def to_s
    if code?
      code + " - " + pacient.name
    else
      pacient.name
    end
  end

  def as_json (options = {})
    super(options.merge!(:include => [:pacient],
        methods: [:last_appointment, :next_valid_appointment_date, :health_insurances_options]))
  end

  def next_valid_appointment_date
    last_appointment.scheduled_at + 30.days if last_appointment
  end

end

