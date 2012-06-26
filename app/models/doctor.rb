class Doctor < User
  attr_accessor :contact_infos_attributes

  validates_presence_of :cpf, :rg, :birthdate, :crm, :appointmentprice
  validates :crm, :numericality => true

  has_many :contact_infos, :as => :reachable

  accepts_nested_attributes_for :contact_infos, :allow_destroy => true

end
