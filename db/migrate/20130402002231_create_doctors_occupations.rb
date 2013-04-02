class CreateDoctorsOccupations < ActiveRecord::Migration
  def up
    create_table :doctors_occupations, :id => false do |t|
      t.references :occupation
      t.references :doctor
    end
  end
  
  def down
    drop_table :doctors_occupations
  end
end
