# -*- encoding : utf-8 -*-
namespace :db do

  desc "Fill database with sample data"

  task :populate => :environment do

    Rake::Task['db:reset'].invoke

    # Categories
    @category_music = Category.create!(:name => "Música")
    @category_language = Category.create!(:name => "Idioma")
    @category_subject = Category.create!(:name => "Asignatura")
    @category_sport = Category.create!(:name => "Deporte")
    @category_free_time = Category.create!(:name => "Hobby")
    @plastic_arts = Category.create!(:name => "Artes Plásticas")

    # Put some activities per category
    @category_music.activities.create!(:name => "Guitarra", :featured => true)
    @category_music.activities.create!(:name => "Violín")
    @category_music.activities.create!(:name => "Piano")

    @category_language.activities.create!(:name => "Inglés", :featured => true)
    @category_language.activities.create!(:name => "Alemán")
    @category_language.activities.create!(:name => "Portugués")
    @category_language.activities.create!(:name => "Chino")

    @category_subject.activities.create!(:name => "Matemática", :featured => true)
    @category_subject.activities.create!(:name => "Química")
    @category_subject.activities.create!(:name => "Física")

    @category_sport.activities.create!(:name => "Fútbol")
    @category_sport.activities.create!(:name => "Tenis")
    @category_sport.activities.create!(:name => "Básquet")
    @category_sport.activities.create!(:name => "Hockey")

    @category_free_time.activities.create!(:name => "Cocina", :featured => true)

    @plastic_arts.activities.create!(:name => "Dibujo")
    @plastic_arts.activities.create!(:name => "Pintura")
    @plastic_arts.activities.create!(:name => "Historia del arte")

    Zone.create!(:name => "Agronomía")
    Zone.create!(:name => "Almagro", :featured => true)
    Zone.create!(:name => "Balvanera", :featured => true)
    Zone.create!(:name => "Barracas")
    Zone.create!(:name => "Belgrano", :featured => true)
    Zone.create!(:name => "Boedo")
    Zone.create!(:name => "Caballito", :featured => false)
    Zone.create!(:name => "Chacarita")
    Zone.create!(:name => "Coghlan")
    Zone.create!(:name => "Colegiales")
    Zone.create!(:name => "Constitución")
    Zone.create!(:name => "Flores")
    Zone.create!(:name => "Floresta")
    Zone.create!(:name => "La Boca")
    Zone.create!(:name => "La Paternal")
    Zone.create!(:name => "Liniers")
    Zone.create!(:name => "Mataderos")
    Zone.create!(:name => "Monte Castro")
    Zone.create!(:name => "Monserrat")
    Zone.create!(:name => "Nueva Pompeya")
    Zone.create!(:name => "Núñez")
    Zone.create!(:name => "Palermo")
    Zone.create!(:name => "Parque Avellaneda")
    Zone.create!(:name => "Parque Chacabuco")
    Zone.create!(:name => "Parque Chas")
    Zone.create!(:name => "Parque Patricios")
    Zone.create!(:name => "Puerto Madero")
    Zone.create!(:name => "Recoleta")
    Zone.create!(:name => "Retiro")
    Zone.create!(:name => "Saavedra")
    Zone.create!(:name => "San Cristóbal")
    Zone.create!(:name => "San Nicolás")
    Zone.create!(:name => "San Telmo")
    Zone.create!(:name => "Vélez Sársfield")
    Zone.create!(:name => "Versalles")
    Zone.create!(:name => "Villa Crespo")
    Zone.create!(:name => "Villa del Parque")
    Zone.create!(:name => "Villa Devoto")
    Zone.create!(:name => "Villa General Mitre")
    Zone.create!(:name => "Villa Lugano")
    Zone.create!(:name => "Villa Luro")
    Zone.create!(:name => "Villa Ortúzar")
    Zone.create!(:name => "Villa Pueyrredón")
    Zone.create!(:name => "Villa Real")
    Zone.create!(:name => "Villa Riachuelo")
    Zone.create!(:name => "Villa Santa Rita")
    Zone.create!(:name => "Villa Soldati")
    Zone.create!(:name => "Villa Talar")
    Zone.create!(:name => "Villa Urquiza")

    # Users
    50.times do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = Faker::Internet.free_email
      cellphone = Faker::PhoneNumber.phone_number
      password = "password"
      password_confirmation = "password"
      avatar = ["avatar_1.jpg", "avatar_2.gif", "avatar_3.png"][Random.new.rand(0..2)]      
      User.create!(:first_name => first_name, :last_name => last_name, :email => email, :cellphone => cellphone, :password => password, :password_confirmation => password_confirmation, :avatar => avatar)
    end

    # Teachers
    50.times do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      description = Faker::Lorem.paragraph
      email = Faker::Internet.free_email
      cellphone = Faker::PhoneNumber.phone_number
      password = "password"
      password_confirmation = "password"
      avatar = ["avatar_1.jpg", "avatar_2.gif", "avatar_3.png"][Random.new.rand(0..2)]
      teacher = Teacher.create!(:first_name => first_name, :last_name => last_name, :description => description, :email => email, :cellphone => cellphone, :password => password, :password_confirmation => password_confirmation, :avatar => avatar)

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

      # Add some random ratings to each teacher.
      user = User.random
      Random.new.rand(1..5).times do
        rating = Random.new.rand(1..5)
        user = User.random while user.has_rated_teacher?(teacher)
        teacher.ratings.create(:user_id => user.id, :rating => rating, :comment => Faker::Lorem.paragraph)
      end

    end

  end
end