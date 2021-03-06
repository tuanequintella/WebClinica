class Occupation < ActiveRecord::Base
  attr_accessible :name, :active

  has_and_belongs_to_many :doctors, :join_table => :doctors_occupations, :class_name => "Doctor"

  scope :active, where(active: true)

  def deactivate!
    if doctors.any?
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
    return 1 if self.active?
    2
  end

  def to_s
  	self.name
  end
end
