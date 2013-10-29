#encoding: utf-8
class Record < ActiveRecord::Base
  extend Enumerize

  attr_accessible :status, :description, :pacient
  attr_accessor :record_entries_attributes

  belongs_to :pacient
  has_many :appointments
  has_many :record_entries, through: :appointments

  enumerize :status, in: [:inactive, :new, :regular, :beginner], default: :new
  accepts_nested_attributes_for :record_entries, :allow_destroy => false
  validates_presence_of :status
  
  I18N_PATH = 'activerecord.attributes.record.'

  def last_appointment
    appointments.with_status(:finished).order("scheduled_at DESC").first
  end

  def deactivate!
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
    "%04d" % self.id
  end
  
  def id_and_pacient
    ("%04d" % self.id) + " " + pacient.name
  end

  def as_json (options = {})
    super(options.merge!(:include => [:pacient], methods: [:last_appointment, :next_valid_appointment_date]))
  end

  def next_valid_appointment_date
    last_appointment.scheduled_at + 30.days if last_appointment
  end

end

