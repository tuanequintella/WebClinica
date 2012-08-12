class CreateOffice < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.timestamps
    end
  end
end
