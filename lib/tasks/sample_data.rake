namespace :db do

  desc "Fill database with sample data"

  task :populate => :environment do

    Rake::Task['db:reset'].invoke

    # Have 3 categories
    3.times do |n|
      name = "Category #{n+1}"
      Category.create!(:name => name)
    end

    # Have 5 activities
    5.times do |n|
      Category.all.each do |category|
        name = "Activity #{n+1} for category #{category.id}"
        category.activities.create!(:name => name)
      end
    end


    Zone.create!(:name => "Almagro")
    Zone.create!(:name => "Villa Crespo")
    Zone.create!(:name => "Palermo")
    Zone.create!(:name => "Recoleta")
    Zone.create!(:name => "Caballito")
    Zone.create!(:name => "Mataderos")
    Zone.create!(:name => "Retiro")
    Zone.create!(:name => "Constitucion")

    50.times do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      description = Faker::Lorem.paragraph
      email = Faker::Internet.free_email
      cellphone = Faker::PhoneNumber.phone_number
      teacher = Teacher.create!(:first_name => first_name, :last_name => last_name, :description => description, :email =>email, :cellphone => cellphone)

      # Add a classroom
      zone = Zone.random
      goes_here = [true, false][Random.new.rand(0..1)]
      receives_people_here = [true, false][Random.new.rand(0..1)]
      # Cannot have them both false
      goes_here = true if (goes_here = false and receives_people_here = false)
      # Create the classroom
      teacher.classrooms.create!(:zone_id => zone.id, :goes_here => goes_here, :receives_people_here => receives_people_here)

      # Add a professorship
      activity = Activity.random
      price_per_hour = Random.new.rand(15..50)
      teacher.professorships.create!(:activity_id => activity.id, :price_per_hour => price_per_hour)
    end

  end
end