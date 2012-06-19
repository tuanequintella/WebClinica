class CreateContactinfo < ActiveRecord::Migration
  def change
    create_table :contactinfos do |t|
      t.string :type,
      t.string :value,
      t.references :reachable, :polymorphic => true
      t.timestamps
  end
end
