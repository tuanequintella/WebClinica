class HealthInsurance < ActiveRecord::Base
  attr_accessible :name
  
  has_many :pacients
  has_and_belongs_to_many :doctors, :join_table => :doctors_health_insurances, :class_name => "User"
end
