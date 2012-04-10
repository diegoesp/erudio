# -*- encoding : utf-8 -*-
class CreateUsers < ActiveRecord::Migration
		def change
				create_table :users do |t|
						t.integer :id
						t.string :last_name
						t.string :first_name
						t.string :email
						t.string :cellphone
						t.string :description
						t.string :type
						t.string :avatar
						
						t.timestamps
				end
		end
end
