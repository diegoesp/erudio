# -*- encoding : utf-8 -*-
# By using the symbol ':category', we get Factory Girl to simulate the Category model.
Factory.define :category do |category|
	category.name "Music"
end

Factory.define :activity do |activity|
	activity.name "Guitar"
	activity.featured true
	activity.association :category
end

Factory.define :user do |user|
	user.first_name "Monica"
	user.last_name "Galindo"
	user.email "monicagalindo@gmail.com"
	user.password "password"
	user.password_confirmation "password"
end

Factory.define :teacher do |teacher|
	teacher.first_name "Octavio"
	teacher.last_name "Pochiero"
	teacher.description "A very talented Graphic Design teacher with extensive experience with adolescent pupils."
	teacher.email "opochiero@gmail.com"
	teacher.password "password"
	teacher.password_confirmation "password"
end

Factory.define :zone do |zone|
	zone.name "Villa Crespo"
end

Factory.define :classroom do |classroom|
	classroom.goes_here false
	classroom.receives_people_here true
end

Factory.define :professorship, :class => Professorship do |professorship|
	professorship.price_per_hour 30
end

Factory.define :zone2, :class => Zone do |zone|
	zone.name "Palermo"
end

Factory.define :teacher2, :class => Teacher do |teacher|
	teacher.first_name "Diego"
	teacher.last_name "Espada"
	teacher.description "A management teacher with bad attitude and a tendency for subversive behaviour."
	teacher.email "diegoesp@gmail.com"
	teacher.password "password"
	teacher.password_confirmation "password"
end

Factory.define :classroom2, :class => Classroom do |classroom|
	classroom.goes_here false
	classroom.receives_people_here true
end

Factory.define :professorship2, :class => Professorship do |professorship|
	professorship.price_per_hour 50
end