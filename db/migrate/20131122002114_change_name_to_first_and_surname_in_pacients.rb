class ChangeNameToFirstAndSurnameInPacients < ActiveRecord::Migration
  def up
    rename_column :pacients, :name, :first_name
    add_column :pacients, :surname, :string

    Pacient.reset_column_information
    Pacient.all.each do |pacient|
      full_name = pacient.first_name.split(" ")
      pacient.first_name = full_name.shift
      pacient.surname = full_name.join(" ")
      pacient.save
    end
  end

  def down
    Pacient.all.each do |pacient|
      full_name = [pacient.first_name, pacient.surname].join(" ")
      pacient.first_name = full_name
      pacient.save
    end

    rename_column :pacients, :first_name, :name
    remove_column :pacients, :surname
  end
end
