class Doctor < User
  attr_accessor :contact_infos_attributes
  attr_accessor :agenda_attributes

  I18N_PATH = 'activerecord.attributes.user.type.'

  validates_presence_of :rg, :birthdate
  validates :crm,:appointmentprice, :presence => true, :numericality => true
  validates :cpf, :presence => true, :cpf => true

  has_many :contact_infos, :as => :reachable
  has_and_belongs_to_many :health_insurances, :join_table => :doctors_health_insurances
  has_and_belongs_to_many :occupations, :join_table => :doctors_occupations
  has_one :agenda

  accepts_nested_attributes_for :contact_infos, :allow_destroy => true
  accepts_nested_attributes_for :agenda

  def to_s
    I18n.t(I18N_PATH + "doctor")
  end

  def deactivate!
    self.agenda.deactivate!
    self.active = false
  end
  
  def activate!
    self.agenda.activate!
    self.active = true
  end

end

