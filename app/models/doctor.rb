class Doctor < User
  attr_accessor :contact_infos_attributes

  validates_presence_of :rg, :birthdate
  validates :crm,:appointmentprice, :presence => true, :numericality => true
  validates :cpf, :presence => true, :cpf => true

  has_many :contact_infos, :as => :reachable

  accepts_nested_attributes_for :contact_infos, :allow_destroy => true

  def to_s
    "Médico"
  end

end
