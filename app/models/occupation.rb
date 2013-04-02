class Occupation < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :doctors, :join_table => :doctors_occupations, :class_name => "User"
end
