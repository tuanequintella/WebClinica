class CreatePacient < ActiveRecord::Migration
  def change
    create_table :pacients do |t|
      t.string :name
      t.string :cpf
      t.string :rg
      t.date :birthdate
      t.string :health_insurances
      t.string :address
      t.string :phone
      t.string :email
      t.string :parent_name
      t.string :parent_rg
      t.string :parent_cpf
      t.timestamps
    end
  end

end
