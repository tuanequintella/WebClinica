class Office < ActiveRecord::Base
  attr_accessor :contact_infos_attributes

  validates_presence_of :name, :email, :address

  has_many :contact_infos, :as => :reachable

  accepts_nested_attributes_for :contact_infos, :allow_destroy => true

  def to_s
    self.name
  end
end
