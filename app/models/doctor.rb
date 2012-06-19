class Doctor < User

  validates_presence_of :cpf, :rg, :birthdate, :crm, :appointmentprice

end
