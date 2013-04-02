class CreateHealthInsurances < ActiveRecord::Migration
  def change
    create_table :health_insurances do |t|
      t.string :name

      t.timestamps
    end
  end
end
