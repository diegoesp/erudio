# By using the symbol ':category', we get Factory Girl to simulate the Category model.
Factory.define :category do |category|
  category.name "Music"
end

Factory.define :activity do |activity|
  activity.name "Guitar"
  activity.association :category
end

Factory.define :teacher do |teacher|
  teacher.first_name "Octavio"
  teacher.last_name "Pochiero"
  teacher.description "A very talented Graphic Design teacher with extensive experience with adolescent pupils."
  teacher.email "opochiero@gmail.com"
end

Factory.define :zone do |zone|
  zone.name "Villa Crespo"
end