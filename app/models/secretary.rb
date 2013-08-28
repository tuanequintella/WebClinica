class Secretary < User
  attr_accessible :cpf, :rg, :birthdate
  attr_accessor :contact_infos_attributes

  I18N_PATH = 'activerecord.attributes.user.type.'

  validates_presence_of :rg, :birthdate
  validates :cpf, :presence => true, :cpf => true

  has_many :contact_infos, :as => :reachable

  accepts_nested_attributes_for :contact_infos, :allow_destroy => true

  def to_s
    I18n.t(I18N_PATH + "secretary")
  end

end
