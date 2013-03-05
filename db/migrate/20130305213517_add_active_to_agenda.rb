class AddActiveToAgenda < ActiveRecord::Migration
  def change
    add_column :agendas, :active, :boolean
  end
end
