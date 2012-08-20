class AddAcceptedHealthInsurancesToUser < ActiveRecord::Migration
  def change
    add_column :users, :accepted_health_insurances, :string
  end
end
