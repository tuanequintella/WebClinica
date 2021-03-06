class Doctor < User
  attr_accessible :cpf, :rg, :birthdate, :crm, :gradyear, :occupation_ids, :appointmentprice, :health_insurance_ids, :contact_infos_attributes, :agenda_attributes
  attr_accessor :contact_infos_attributes
  attr_accessor :agenda_attributes

  I18N_PATH = 'activerecord.attributes.user.type.'

  validates_presence_of :rg, :birthdate
  validates :crm,:appointmentprice, :presence => true, :numericality => true
  validates :cpf, :presence => true, :cpf => true

  has_many :contact_infos, :as => :reachable
  has_and_belongs_to_many :health_insurances, :join_table => :doctors_health_insurances, foreign_key: :doctor_id
  has_and_belongs_to_many :occupations, :join_table => :doctors_occupations, foreign_key: :doctor_id
  has_one :agenda

  accepts_nested_attributes_for :contact_infos, :allow_destroy => true
  accepts_nested_attributes_for :agenda

  scope :active, where(active: true)

  def to_s
    I18n.t(I18N_PATH + "doctor")
  end

  def deactivate!
    if agenda.appointments.select{|app| app.scheduled_at > Time.now}.any?
      return false
    end
    self.agenda.deactivate!
    self.active = false
    self.save
  end
  
  def activate!
    self.agenda.activate!
    self.active = true
    self.save
  end

end

