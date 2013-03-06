class Pacient < ActiveRecord::Base
  attr_accessible :name, :cpf, :rg, :birthdate, :health_insurances, :address, :phone, :email, :parent_name, :parent_rg, :parent_cpf, :contact_infos_attributes, :record_attributes
  attr_accessor :contact_infos_attributes, :record_attributes

  validates_presence_of :name, :email, :address, :phone, :birthdate
  validates :rg, :cpf, :presence => { :if => :overage? }
  validates :parent_name, :parent_rg, :parent_cpf, :presence => { :unless => :overage? }

  has_many :contact_infos, :as => :reachable
  has_one :record

  accepts_nested_attributes_for :record, :contact_infos, :allow_destroy => true

  def to_s
    self.name
  end

  def overage?
    my_age = self.age
    if my_age[:years] >=18
      true
    else
      false
    end
  end

  def active?
    self.record.status == Record.INACTIVE
  end

  def age
    years = Date.today.year - birthdate.year
    months = Date.today.month - birthdate.month
    if Date.today.month < birthdate.month || (Date.today.month == birthdate.month && birthdate.day >= Date.today.day)
      years  = years  - 1
      months = months + 12
      if birthdate.day >= Date.today.day
        months = months - 1
      end
    end
    {:years => years, :months => months}
  end

  def age_in_words
    my_age = self.age
    I18n.t('datetime.distance_in_words.x_years', :count => my_age[:years] ) + " " + I18n.t('datetime.distance_in_words.x_months', :count => my_age[:months] )
  end

  def self.search (term)
    if term.present?
      where("name LIKE ?", "%#{term}%")
    else
      all
    end
  end

end
