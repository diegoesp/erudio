class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :id
      t.string :last_name
      t.string :first_name
      t.string :description
      t.string :email
      t.string :cellphone

      t.timestamps
    end
  end
end
