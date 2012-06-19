class ContactInfo < ActiveRecord::Base
  belongs_to :reachable, :polymorphic => true
end
