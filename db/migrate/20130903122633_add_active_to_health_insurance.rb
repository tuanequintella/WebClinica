class AddActiveToHealthInsurance < ActiveRecord::Migration
  def change
    add_column :health_insurances, :active, :boolean, :default => true
  end
end
