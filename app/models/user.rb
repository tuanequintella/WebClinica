class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  authenticates_with_sorcery!

  validates_presence_of :name, :username, :email
  validates_uniqueness_of :username, :email, :case_sensitive => false
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

end
