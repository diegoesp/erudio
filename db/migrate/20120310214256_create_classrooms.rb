# -*- encoding : utf-8 -*-
class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.integer :teacher_id
      t.integer :zone_id
      t.boolean :goes_here
      t.boolean :receives_people_here

      t.timestamps
    end
  end
end
