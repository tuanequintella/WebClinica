class Record < ActiveRecord::Base

  attr_accessible :code, :status, :description, :pacient
  belongs_to :pacient
  has_many :appointments
  
  INACTIVE = "inactive"
  NEW = "new"
  REGULAR = "regular"
  BEGINNER = "beginner"
  
  
  I18N_PATH = 'activerecord.attributes.record.'

  def self.status
    [[I18n.t(I18N_PATH + NEW), NEW], [I18n.t(I18N_PATH + REGULAR), REGULAR], [I18n.t(I18N_PATH + BEGINNER), BEGINNER], [I18n.t(I18N_PATH + INACTIVE), INACTIVE]]
  end
  
  def deactivate!
    self.status = INACTIVE
  end
  
  def activate!
    self.status = REGULAR
  end
  
  def active?
    unless self.status == INACTIVE
      true
    else
      false
    end
  end

end

