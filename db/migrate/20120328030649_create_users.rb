# -*- encoding : utf-8 -*-
class CreateUsers < ActiveRecord::Migration
		def change
				create_table :users do |t|
						t.integer :id
						t.string :last_name
						t.string :first_name
						t.string :email
						t.string :phone
						t.string :description
						t.string :avatar
						t.boolean :publish_email
						t.boolean :publish_phone
						t.string :type
						
						t.timestamps
				end
		end
end
