class CreateCids < ActiveRecord::Migration
  def change
    create_table :cids do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
