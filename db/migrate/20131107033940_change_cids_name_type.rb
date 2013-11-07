class ChangeCidsNameType < ActiveRecord::Migration
  def up
    change_column :cids, :name, :text
  end

  def down
    change_column :cids, :name, :string
  end
end
