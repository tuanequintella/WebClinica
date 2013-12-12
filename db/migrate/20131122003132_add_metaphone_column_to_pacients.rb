class AddMetaphoneColumnToPacients < ActiveRecord::Migration
  def up
    add_column :pacients, :name_metaphone, :string

    Pacient.reset_column_information
    Pacient.all.each do |pacient|
      pacient.name_metaphone = MetaphoneBr.metaphone_ptbr(pacient.name)
      pacient.save(validate: false)
    end
  end

  def down
    remove_column :pacients, :name_metaphone
  end
end
