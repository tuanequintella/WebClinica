class CreateContactInfo < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.references :reachable, :polymorphic => true
      t.string :type
      t.string :value
      t.timestamps
    end
  end
end
