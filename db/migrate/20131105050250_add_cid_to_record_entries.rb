class AddCidToRecordEntries < ActiveRecord::Migration
  def change
    add_column :record_entries, :cid_id, :integer
  end
end
