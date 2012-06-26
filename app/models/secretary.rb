class Secretary < User
  attr_accessor :contact_infos_attributes

  validates_presence_of :rg, :birthdate
  validates :cpf, :presence => true, :cpf => true

  has_many :contact_infos, :as => :reachable

  accepts_nested_attributes_for :contact_infos, :allow_destroy => true

end
