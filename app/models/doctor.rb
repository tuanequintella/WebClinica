class Doctor < User
  attr_accessor :contact_infos_attributes

  I18N_PATH = 'activerecord.attributes.user.type.'

  validates_presence_of :rg, :birthdate
  validates :crm,:appointmentprice, :presence => true, :numericality => true
  validates :cpf, :presence => true, :cpf => true

  has_many :contact_infos, :as => :reachable
  has_one :agenda

  accepts_nested_attributes_for :contact_infos, :allow_destroy => true

  before_create :create_agenda

  def create_agenda
    self.agenda = Agenda.new
  end

  def to_s
    I18n.t(I18N_PATH + "doctor")
  end

end
