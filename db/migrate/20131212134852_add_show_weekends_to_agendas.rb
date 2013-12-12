class AddShowWeekendsToAgendas < ActiveRecord::Migration
  def change
    add_column :agendas, :show_weekend, :string, default: 'none'
  end
end
