# -*- encoding : utf-8 -*-
class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :id
      t.string :name
      t.integer :category_id

      t.timestamps
    end
  end
end
