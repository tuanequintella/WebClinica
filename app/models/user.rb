class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  authenticates_with_sorcery!

  validates_presence_of :name, :username, :email
  validates_uniqueness_of :username, :email, :case_sensitive => false
  validates_uniqueness_of :cpf, :rg, :allow_blank => true
  validates_confirmation_of :password, :if => :password

end
