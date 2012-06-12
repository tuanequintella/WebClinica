class Secretary < User

  validates_presence_of :cpf, :rg, :birthdate

end
