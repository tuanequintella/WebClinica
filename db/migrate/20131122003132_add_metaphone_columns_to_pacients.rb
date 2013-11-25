class AddMetaphoneColumnsToPacients < ActiveRecord::Migration
  def up
    add_column :pacients, :first_name_metaphone, :string
    add_column :pacients, :surname_metaphone, :string

    Pacient.reset_column_information
    Pacient.all.each do |pacient|
      pacient.first_name_metaphone = MetaphoneBr.metaphone_ptbr(pacient.first_name)
      pacient.surname_metaphone = MetaphoneBr.metaphone_ptbr(pacient.surname)
      pacient.save(validate: false)
    end
  end

  def down
    remove_column :pacients, :first_name_metaphone
    remove_column :pacients, :surname_metaphone
  end
end
