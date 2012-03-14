class CreateProfessorships < ActiveRecord::Migration
  def change
    create_table :professorships do |t|
      t.integer :teacher_id
      t.integer :activity_id
      t.integer :price_per_hour

      t.timestamps
    end
  end
end
