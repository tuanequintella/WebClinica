class HealthInsurance < ActiveRecord::Base
  attr_accessible :name, :active
  
  has_many :appointments
  has_many :pacients
  has_and_belongs_to_many :doctors, :join_table => :doctors_health_insurances, :class_name => "Doctor"

  scope :active, where(active: true)

  def deactivate!
    if doctors.any? || appointments.select{|app| app.scheduled_at > Time.now}.any?
      return false
    end
    self.active = false
    self.save
  end
  
  def activate!
    self.active = true
    self.save
  end

  def active_number
    return 0 if self.name == "Sem convênio (particular)"
    return 1 if self.active?
    2
  end

  def to_s
  	self.name
  end
end
