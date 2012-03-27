class AddFeaturedToZone < ActiveRecord::Migration
  def change
    add_column :zones, :featured, :boolean, :default => false
  end
end
