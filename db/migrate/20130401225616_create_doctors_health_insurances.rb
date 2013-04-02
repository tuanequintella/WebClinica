class CreateDoctorsHealthInsurances < ActiveRecord::Migration
  def up
    create_table :doctors_health_insurances, :id => false do |t|
      t.references :health_insurance
      t.references :doctor
    end
  end
  
  def down
    drop_table :doctors_health_insurances
  end

end
