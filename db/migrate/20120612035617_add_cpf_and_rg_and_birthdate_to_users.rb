class AddCpfAndRgAndBirthdateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cpf, :string
    add_column :users, :rg, :string
    add_column :users, :birthdate, :date
  end
end
