class AddFeaturedToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :featured, :boolean, :default => false
  end
end
