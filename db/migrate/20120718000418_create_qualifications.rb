class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.string :name
      t.string :institute
      t.integer :teacher_id

      t.timestamps
    end
  end
end
