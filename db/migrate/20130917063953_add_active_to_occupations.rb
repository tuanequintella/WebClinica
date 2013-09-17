class AddActiveToOccupations < ActiveRecord::Migration
  def change
    add_column :occupations, :active, :boolean, :default => true
  end
end
