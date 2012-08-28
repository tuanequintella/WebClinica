class RemoveAgeFromPacient < ActiveRecord::Migration
  def change
    remove_column :pacients, :age
  end
end
