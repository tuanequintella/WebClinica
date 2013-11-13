class HealthInsurance < ActiveRecord::Base
  attr_accessible :name, :active
  
  has_many :appointments
  has_many :pacients
  has_and_belongs_to_many :doctors, :join_table => :doctors_health_insurances, :class_name => "User"

  scope :active, where(active: true)

  def deactivate!
    if pacients.any? || doctors.any? || appointments.any?
      return false
    end
    self.active = false
    self.save
  end
  
  def activate!
    self.active = true
    self.save
  end

  def to_s
  	self.name
  end
end
