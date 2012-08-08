class ContactInfo < ActiveRecord::Base

  I18N_PATH = 'activerecord.attributes.contact_info.type.'

  attr_accessible :type, :value

  belongs_to :reachable, :polymorphic => true

  def self.contact_types
    [[I18n.t(I18N_PATH + 'Phone'), "Phone"], [I18n.t(I18N_PATH + 'Email'),"Email"], [I18n.t(I18N_PATH + 'Address'),"Address"], [I18n.t(I18N_PATH + 'Webpage'),"Webpage"]]
  end

  def to_s
    value
  end

end
