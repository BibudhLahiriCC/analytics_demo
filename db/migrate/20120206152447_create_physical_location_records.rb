class CreatePhysicalLocationRecords < ActiveRecord::Migration
  def self.up
    create_table :physical_location_records do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :physical_location_records
  end
end
