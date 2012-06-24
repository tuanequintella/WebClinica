class ContactInfo < ActiveRecord::Base

  I18N_PATH = 'activerecord.attributes.contact_info.contact_type.'

  attr_accessible :contact_type, :value

  belongs_to :reachable, :polymorphic => true

  def self.contact_types
    [I18n.t(I18N_PATH + 'phone'), I18n.t(I18N_PATH + 'email'), I18n.t(I18N_PATH + 'address'), I18n.t(I18N_PATH + 'webpage')]
  end
end
