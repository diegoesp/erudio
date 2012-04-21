class CreateContiguousZones < ActiveRecord::Migration
  def change
    create_table 'contiguous_zones', :id => false do |t|
    t.column :zone_id, :integer
    t.column :contiguous_zone_id, :integer
    end
  end
  
  def self.down
    drop_table:'contiguous_zones'
  end
end
