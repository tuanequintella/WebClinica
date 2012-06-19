class Secretary < User

  validates_presence_of :cpf, :rg, :birthdate

  has_many :contactinfos, :as => :reachable

end
