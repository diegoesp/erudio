# -*- encoding : utf-8 -*-
namespace :db do

  desc "Fill database with sample data"

  task :populate => :environment do

    Rake::Task['db:reset'].invoke

    # Categories
    print "Creating categories\n"

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

    # Zones are neighborhoods, or "barrios". They're taken form Wikipedia, here => http://en.wikipedia.org/wiki/Barrios_and_Communes_of_Buenos_Aires
    print "Creating zones\n"

    @zone_agronomia = Zone.create!(:name => "Agronomía")
    @zone_almagro = Zone.create!(:name => "Almagro", :featured => true)
    @zone_balvanera = Zone.create!(:name => "Balvanera", :featured => true)
    @zone_barracas = Zone.create!(:name => "Barracas")
    @zone_belgrano = Zone.create!(:name => "Belgrano", :featured => true)
    @zone_boedo = Zone.create!(:name => "Boedo")
    @zone_caballito = Zone.create!(:name => "Caballito", :featured => true)
    @zone_chacarita = Zone.create!(:name => "Chacarita")
    @zone_coghlan = Zone.create!(:name => "Coghlan")
    @zone_colegiales = Zone.create!(:name => "Colegiales")
    @zone_constitucion = Zone.create!(:name => "Constitución")
    @zone_flores = Zone.create!(:name => "Flores")
    @zone_floresta = Zone.create!(:name => "Floresta")
    @zone_la_boca = Zone.create!(:name => "La Boca")
    @zone_la_paternal = Zone.create!(:name => "La Paternal")
    @zone_liniers = Zone.create!(:name => "Liniers")
    @zone_mataderos = Zone.create!(:name => "Mataderos")
    @zone_monte_castro = Zone.create!(:name => "Monte Castro")
    @zone_monserrat = Zone.create!(:name => "Monserrat")
    @zone_nueva_pompeya = Zone.create!(:name => "Nueva Pompeya")
    @zone_nunez = Zone.create!(:name => "Núñez")
    @zone_palermo = Zone.create!(:name => "Palermo", :featured => true)
    @zone_parque_avellaneda = Zone.create!(:name => "Parque Avellaneda")
    @zone_parque_chacabuco = Zone.create!(:name => "Parque Chacabuco")
    @zone_parque_chas = Zone.create!(:name => "Parque Chas")
    @zone_parque_patricios = Zone.create!(:name => "Parque Patricios")
    @zone_puerto_madero = Zone.create!(:name => "Puerto Madero")
    @zone_recoleta = Zone.create!(:name => "Recoleta", :featured => true)
    @zone_retiro = Zone.create!(:name => "Retiro")
    @zone_saavedra = Zone.create!(:name => "Saavedra")
    @zone_san_cristobal = Zone.create!(:name => "San Cristóbal")
    @zone_san_nicolas = Zone.create!(:name => "San Nicolás")
    @zone_san_telmo = Zone.create!(:name => "San Telmo")
    @zone_velez_sarsfield = Zone.create!(:name => "Vélez Sársfield")
    @zone_versalles = Zone.create!(:name => "Versalles")
    @zone_villa_crespo = Zone.create!(:name => "Villa Crespo")
    @zone_villa_del_parque = Zone.create!(:name => "Villa del Parque")
    @zone_villa_devoto = Zone.create!(:name => "Villa Devoto")
    @zone_villa_general_mitre = Zone.create!(:name => "Villa General Mitre")
    @zone_villa_lugano = Zone.create!(:name => "Villa Lugano")
    @zone_villa_luro = Zone.create!(:name => "Villa Luro")
    @zone_villa_ortuzar = Zone.create!(:name => "Villa Ortúzar")
    @zone_villa_pueyrredon = Zone.create!(:name => "Villa Pueyrredón")
    @zone_villa_real = Zone.create!(:name => "Villa Real")
    @zone_villa_riachuelo = Zone.create!(:name => "Villa Riachuelo")
    @zone_villa_santa_rita = Zone.create!(:name => "Villa Santa Rita")
    @zone_villa_soldati = Zone.create!(:name => "Villa Soldati")
    @zone_villa_talar = Zone.create!(:name => "Villa Talar")
    @zone_villa_urquiza = Zone.create!(:name => "Villa Urquiza")

    # Relationships between zones was created using http://mapa.buenosaires.gob.ar/
    # The zones are neighborhoods. They're reviewed from north to south. I start with Nuñez and end with Villa Riachuelo.
    print "Creating relationship between zones (contiguous zones)\n"

    @zone_nunez.contiguous_zones << @zone_saavedra
    @zone_nunez.contiguous_zones << @zone_belgrano
    @zone_nunez.contiguous_zones << @zone_coghlan
    @zone_saavedra.contiguous_zones << @zone_nunez
    @zone_saavedra.contiguous_zones << @zone_belgrano
    @zone_saavedra.contiguous_zones << @zone_coghlan
    @zone_saavedra.contiguous_zones << @zone_villa_urquiza
    @zone_belgrano.contiguous_zones << @zone_nunez
    @zone_belgrano.contiguous_zones << @zone_saavedra
    @zone_belgrano.contiguous_zones << @zone_coghlan        
    @zone_belgrano.contiguous_zones << @zone_colegiales    
    @zone_belgrano.contiguous_zones << @zone_palermo
    @zone_belgrano.contiguous_zones << @zone_villa_ortuzar
    @zone_coghlan.contiguous_zones << @zone_nunez
    @zone_coghlan.contiguous_zones << @zone_saavedra
    @zone_coghlan.contiguous_zones << @zone_belgrano
    @zone_coghlan.contiguous_zones << @zone_villa_urquiza 
    @zone_coghlan.contiguous_zones << @zone_colegiales
    @zone_coghlan.contiguous_zones << @zone_palermo
    @zone_villa_urquiza.contiguous_zones << @zone_coghlan
    @zone_villa_urquiza.contiguous_zones << @zone_colegiales    
    @zone_villa_urquiza.contiguous_zones << @zone_palermo    
    @zone_villa_urquiza.contiguous_zones << @zone_villa_ortuzar    
    @zone_villa_urquiza.contiguous_zones << @zone_villa_pueyrredon
    @zone_villa_urquiza.contiguous_zones << @zone_parque_chas
    @zone_colegiales.contiguous_zones << @zone_belgrano
    @zone_colegiales.contiguous_zones << @zone_coghlan
    @zone_colegiales.contiguous_zones << @zone_villa_urquiza
    @zone_colegiales.contiguous_zones << @zone_palermo
    @zone_colegiales.contiguous_zones << @zone_villa_ortuzar
    @zone_colegiales.contiguous_zones << @zone_villa_pueyrredon
    @zone_colegiales.contiguous_zones << @zone_parque_chas
    @zone_colegiales.contiguous_zones << @zone_chacarita
    @zone_colegiales.contiguous_zones << @zone_recoleta
    @zone_palermo.contiguous_zones << @zone_belgrano
    @zone_palermo.contiguous_zones << @zone_coghlan
    @zone_palermo.contiguous_zones << @zone_villa_urquiza
    @zone_palermo.contiguous_zones << @zone_colegiales
    @zone_palermo.contiguous_zones << @zone_villa_ortuzar
    @zone_palermo.contiguous_zones << @zone_chacarita
    @zone_palermo.contiguous_zones << @zone_recoleta
    @zone_palermo.contiguous_zones << @zone_villa_crespo
    @zone_palermo.contiguous_zones << @zone_almagro
    @zone_villa_ortuzar.contiguous_zones << @zone_belgrano
    @zone_villa_ortuzar.contiguous_zones << @zone_villa_urquiza
    @zone_villa_ortuzar.contiguous_zones << @zone_colegiales
    @zone_villa_ortuzar.contiguous_zones << @zone_palermo
    @zone_villa_ortuzar.contiguous_zones << @zone_villa_pueyrredon
    @zone_villa_ortuzar.contiguous_zones << @zone_parque_chas
    @zone_villa_ortuzar.contiguous_zones << @zone_chacarita
    @zone_villa_pueyrredon.contiguous_zones << @zone_villa_urquiza
    @zone_villa_pueyrredon.contiguous_zones << @zone_parque_chas
    @zone_villa_pueyrredon.contiguous_zones << @zone_agronomia
    @zone_villa_pueyrredon.contiguous_zones << @zone_villa_del_parque
    @zone_villa_pueyrredon.contiguous_zones << @zone_villa_devoto
    @zone_parque_chas.contiguous_zones << @zone_villa_ortuzar
    @zone_parque_chas.contiguous_zones << @zone_villa_pueyrredon
    @zone_parque_chas.contiguous_zones << @zone_chacarita 
    @zone_parque_chas.contiguous_zones << @zone_agronomia
    @zone_parque_chas.contiguous_zones << @zone_la_paternal
    @zone_chacarita.contiguous_zones << @zone_colegiales    
    @zone_chacarita.contiguous_zones << @zone_palermo
    @zone_chacarita.contiguous_zones << @zone_villa_ortuzar
    @zone_chacarita.contiguous_zones << @zone_parque_chas
    @zone_chacarita.contiguous_zones << @zone_agronomia        
    @zone_chacarita.contiguous_zones << @zone_la_paternal
    @zone_chacarita.contiguous_zones << @zone_villa_crespo
    @zone_chacarita.contiguous_zones << @zone_recoleta
    @zone_agronomia.contiguous_zones << @zone_villa_pueyrredon
    @zone_agronomia.contiguous_zones << @zone_parque_chas
    @zone_agronomia.contiguous_zones << @zone_chacarita
    @zone_agronomia.contiguous_zones << @zone_la_paternal
    @zone_agronomia.contiguous_zones << @zone_villa_del_parque
    @zone_agronomia.contiguous_zones << @zone_villa_devoto
    @zone_recoleta.contiguous_zones << @zone_palermo
    @zone_recoleta.contiguous_zones << @zone_colegiales
    @zone_recoleta.contiguous_zones << @zone_villa_ortuzar
    @zone_recoleta.contiguous_zones << @zone_chacarita
    @zone_recoleta.contiguous_zones << @zone_villa_crespo
    @zone_recoleta.contiguous_zones << @zone_almagro
    @zone_recoleta.contiguous_zones << @zone_san_nicolas
    @zone_recoleta.contiguous_zones << @zone_puerto_madero
    @zone_la_paternal.contiguous_zones << @zone_parque_chas
    @zone_la_paternal.contiguous_zones << @zone_chacarita
    @zone_la_paternal.contiguous_zones << @zone_agronomia
    @zone_la_paternal.contiguous_zones << @zone_villa_crespo
    @zone_la_paternal.contiguous_zones << @zone_villa_del_parque
    @zone_la_paternal.contiguous_zones << @zone_villa_general_mitre
    @zone_villa_crespo.contiguous_zones << @zone_palermo
    @zone_villa_crespo.contiguous_zones << @zone_chacarita
    @zone_villa_crespo.contiguous_zones << @zone_recoleta
    @zone_villa_crespo.contiguous_zones << @zone_villa_del_parque
    @zone_villa_crespo.contiguous_zones << @zone_almagro
    @zone_villa_crespo.contiguous_zones << @zone_villa_general_mitre
    @zone_villa_crespo.contiguous_zones << @zone_caballito
    @zone_villa_del_parque.contiguous_zones << @zone_agronomia
    @zone_villa_del_parque.contiguous_zones << @zone_la_paternal
    @zone_villa_del_parque.contiguous_zones << @zone_villa_crespo
    @zone_villa_del_parque.contiguous_zones << @zone_villa_devoto
    @zone_villa_del_parque.contiguous_zones << @zone_villa_general_mitre
    @zone_villa_del_parque.contiguous_zones << @zone_villa_santa_rita
    @zone_villa_del_parque.contiguous_zones << @zone_monte_castro
    @zone_san_nicolas.contiguous_zones << @zone_recoleta
    @zone_san_nicolas.contiguous_zones << @zone_balvanera
    @zone_san_nicolas.contiguous_zones << @zone_monserrat
    @zone_san_nicolas.contiguous_zones << @zone_puerto_madero
    @zone_almagro.contiguous_zones << @zone_palermo
    @zone_almagro.contiguous_zones << @zone_recoleta
    @zone_almagro.contiguous_zones << @zone_villa_crespo
    @zone_almagro.contiguous_zones << @zone_balvanera
    @zone_almagro.contiguous_zones << @zone_caballito
    @zone_almagro.contiguous_zones << @zone_san_cristobal
    @zone_villa_devoto.contiguous_zones << @zone_villa_pueyrredon
    @zone_villa_devoto.contiguous_zones << @zone_agronomia
    @zone_villa_devoto.contiguous_zones << @zone_villa_del_parque
    @zone_villa_devoto.contiguous_zones << @zone_villa_santa_rita
    @zone_villa_devoto.contiguous_zones << @zone_monte_castro
    @zone_villa_devoto.contiguous_zones << @zone_versalles
    @zone_villa_general_mitre.contiguous_zones << @zone_la_paternal
    @zone_villa_general_mitre.contiguous_zones << @zone_villa_del_parque
    @zone_villa_general_mitre.contiguous_zones << @zone_villa_crespo
    @zone_villa_general_mitre.contiguous_zones << @zone_villa_santa_rita
    @zone_villa_general_mitre.contiguous_zones << @zone_monte_castro
    @zone_villa_general_mitre.contiguous_zones << @zone_flores
    @zone_villa_general_mitre.contiguous_zones << @zone_caballito
    @zone_balvanera.contiguous_zones << @zone_recoleta
    @zone_balvanera.contiguous_zones << @zone_almagro
    @zone_balvanera.contiguous_zones << @zone_san_nicolas
    @zone_balvanera.contiguous_zones << @zone_monserrat
    @zone_balvanera.contiguous_zones << @zone_san_cristobal
    @zone_puerto_madero.contiguous_zones << @zone_recoleta
    @zone_puerto_madero.contiguous_zones << @zone_san_nicolas
    @zone_puerto_madero.contiguous_zones << @zone_monserrat
    @zone_puerto_madero.contiguous_zones << @zone_la_boca
    @zone_monserrat.contiguous_zones << @zone_san_nicolas
    @zone_monserrat.contiguous_zones << @zone_balvanera
    @zone_monserrat.contiguous_zones << @zone_puerto_madero
    @zone_monserrat.contiguous_zones << @zone_san_cristobal
    @zone_monserrat.contiguous_zones << @zone_la_boca
    @zone_villa_santa_rita.contiguous_zones << @zone_villa_del_parque
    @zone_villa_santa_rita.contiguous_zones << @zone_villa_devoto
    @zone_villa_santa_rita.contiguous_zones << @zone_villa_general_mitre
    @zone_villa_santa_rita.contiguous_zones << @zone_caballito
    @zone_villa_santa_rita.contiguous_zones << @zone_monte_castro
    @zone_villa_santa_rita.contiguous_zones << @zone_floresta
    @zone_villa_santa_rita.contiguous_zones << @zone_flores
    @zone_caballito.contiguous_zones << @zone_villa_crespo
    @zone_caballito.contiguous_zones << @zone_almagro
    @zone_caballito.contiguous_zones << @zone_villa_general_mitre
    @zone_caballito.contiguous_zones << @zone_flores
    @zone_caballito.contiguous_zones << @zone_parque_chacabuco
    @zone_caballito.contiguous_zones << @zone_san_cristobal
    @zone_monte_castro.contiguous_zones << @zone_villa_devoto
    @zone_monte_castro.contiguous_zones << @zone_villa_santa_rita
    @zone_monte_castro.contiguous_zones << @zone_floresta
    @zone_monte_castro.contiguous_zones << @zone_versalles
    @zone_monte_castro.contiguous_zones << @zone_velez_sarsfield
    @zone_san_cristobal.contiguous_zones << @zone_almagro
    @zone_san_cristobal.contiguous_zones << @zone_balvanera
    @zone_san_cristobal.contiguous_zones << @zone_monserrat      
    @zone_san_cristobal.contiguous_zones << @zone_caballito
    @zone_san_cristobal.contiguous_zones << @zone_parque_chacabuco
    @zone_san_cristobal.contiguous_zones << @zone_parque_patricios
    @zone_san_cristobal.contiguous_zones << @zone_la_boca
    @zone_san_cristobal.contiguous_zones << @zone_barracas
    @zone_floresta.contiguous_zones << @zone_villa_santa_rita
    @zone_floresta.contiguous_zones << @zone_monte_castro
    @zone_floresta.contiguous_zones << @zone_versalles
    @zone_floresta.contiguous_zones << @zone_velez_sarsfield
    @zone_floresta.contiguous_zones << @zone_flores
    @zone_floresta.contiguous_zones << @zone_liniers
    @zone_versalles.contiguous_zones << @zone_monte_castro
    @zone_versalles.contiguous_zones << @zone_velez_sarsfield
    @zone_versalles.contiguous_zones << @zone_liniers
    @zone_velez_sarsfield.contiguous_zones << @zone_monte_castro
    @zone_velez_sarsfield.contiguous_zones << @zone_floresta
    @zone_velez_sarsfield.contiguous_zones << @zone_versalles
    @zone_velez_sarsfield.contiguous_zones << @zone_flores
    @zone_velez_sarsfield.contiguous_zones << @zone_liniers
    @zone_parque_chacabuco.contiguous_zones << @zone_caballito
    @zone_parque_chacabuco.contiguous_zones << @zone_san_cristobal
    @zone_parque_chacabuco.contiguous_zones << @zone_flores
    @zone_parque_chacabuco.contiguous_zones << @zone_parque_patricios
    @zone_parque_chacabuco.contiguous_zones << @zone_nueva_pompeya
    @zone_la_boca.contiguous_zones << @zone_puerto_madero
    @zone_la_boca.contiguous_zones << @zone_monserrat
    @zone_la_boca.contiguous_zones << @zone_san_cristobal
    @zone_la_boca.contiguous_zones << @zone_parque_patricios
    @zone_la_boca.contiguous_zones << @zone_barracas
    @zone_flores.contiguous_zones << @zone_caballito
    @zone_flores.contiguous_zones << @zone_floresta
    @zone_flores.contiguous_zones << @zone_velez_sarsfield
    @zone_flores.contiguous_zones << @zone_parque_chacabuco
    @zone_flores.contiguous_zones << @zone_nueva_pompeya
    @zone_flores.contiguous_zones << @zone_liniers
    @zone_flores.contiguous_zones << @zone_mataderos
    @zone_flores.contiguous_zones << @zone_villa_lugano
    @zone_parque_patricios.contiguous_zones << @zone_san_cristobal
    @zone_parque_patricios.contiguous_zones << @zone_parque_chacabuco
    @zone_parque_patricios.contiguous_zones << @zone_la_boca
    @zone_parque_patricios.contiguous_zones << @zone_barracas
    @zone_parque_patricios.contiguous_zones << @zone_nueva_pompeya
    @zone_liniers.contiguous_zones << @zone_floresta
    @zone_liniers.contiguous_zones << @zone_versalles
    @zone_liniers.contiguous_zones << @zone_flores
    @zone_liniers.contiguous_zones << @zone_mataderos
    @zone_barracas.contiguous_zones << @zone_san_cristobal
    @zone_barracas.contiguous_zones << @zone_la_boca
    @zone_barracas.contiguous_zones << @zone_parque_patricios
    @zone_barracas.contiguous_zones << @zone_nueva_pompeya
    @zone_barracas.contiguous_zones << @zone_la_boca
    @zone_nueva_pompeya.contiguous_zones << @zone_parque_chacabuco
    @zone_nueva_pompeya.contiguous_zones << @zone_flores
    @zone_nueva_pompeya.contiguous_zones << @zone_parque_patricios
    @zone_nueva_pompeya.contiguous_zones << @zone_barracas
    @zone_nueva_pompeya.contiguous_zones << @zone_villa_lugano
    @zone_mataderos.contiguous_zones << @zone_liniers
    @zone_mataderos.contiguous_zones << @zone_flores
    @zone_mataderos.contiguous_zones << @zone_villa_lugano
    @zone_mataderos.contiguous_zones << @zone_villa_riachuelo
    @zone_villa_lugano.contiguous_zones << @zone_mataderos
    @zone_villa_lugano.contiguous_zones << @zone_nueva_pompeya
    @zone_villa_lugano.contiguous_zones << @zone_flores
    @zone_villa_lugano.contiguous_zones << @zone_villa_riachuelo
    @zone_villa_riachuelo.contiguous_zones << @zone_mataderos
    @zone_villa_riachuelo.contiguous_zones << @zone_villa_lugano

    # Users
    50.times do |user_number|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = Faker::Internet.free_email
      cellphone = Faker::PhoneNumber.phone_number
      password = "password"
      password_confirmation = "password"
      avatar = ["avatar_1.jpg", "avatar_2.gif", "avatar_3.png"][Random.new.rand(0..2)]      
      User.create!(:first_name => first_name, 
        :last_name => last_name, 
        :email => email, 
        :cellphone => cellphone, 
        :password => password, 
        :password_confirmation => password_confirmation, 
        :avatar => avatar)

      print "Created user #{user_number+1} for #{last_name}, #{first_name}\n"
    end

    # Create some teachers for each combination of featured zones and activities 
    zones = Zone.find_all_by_featured(true)
    activities = Activity.find_all_by_featured(true)
    
    print "Creating teachers => Estimated quantity is #{zones.count * activities.count * 11}\n"

    teacher_number = 0

    # for each featured zone...
    zones.each do |zone|
      # ...and for each featured activity...      
      activities.each do |activity|
        # ... add between 10 and 12 teachers
        Random.new.rand(10..12).times do
            hash = create_teacher(zone, activity, Random.new.rand(0..4))
            teacher_number += 1
            print "Created teacher #{teacher_number} for #{hash[:last_name]}, #{hash[:first_name]}\n"
        end
      end      
    end

  end

  # Creates a teacher in the database using the zone and activity received
  #
  # @param zone Zone to be used
  # @param activity Activity to be used
  # @param random_activities_number [Integer] Optional. number of additional random activities to be added to the teacher. They will be added with the same price.
  # @return [Hash] a hash containing the last_name and first_name keys
  def create_teacher(zone, activity, random_activities_number = 0)

    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    description = Faker::Lorem.paragraph(10)
    email = Faker::Internet.free_email
    phone = Faker::PhoneNumber.phone_number
    password = "password"
    password_confirmation = "password"
    avatar = ["avatar_1.jpg", "avatar_2.gif", "avatar_3.png"][Random.new.rand(0..2)]
    publish_email = [true, false][Random.new.rand(0..1)]
    publish_phone = [true, false][Random.new.rand(0..1)]
    teacher = Teacher.create!(:first_name => first_name, 
        :last_name => last_name, 
        :description => description, 
        :email => email, 
        :phone => phone, 
        :password => password, 
        :password_confirmation => password_confirmation,
        :avatar => avatar,
        :publish_email => publish_email,
        :publish_phone => publish_phone)

    # Add a classroom
    goes_here = [true, false][Random.new.rand(0..1)]
    receives_people_here = [true, false][Random.new.rand(0..1)]
    # Cannot have them both false
    goes_here = true if (goes_here == false and receives_people_here == false) 
    # Create the classroom
    teacher.classrooms.create!(:zone_id => zone.id, :goes_here => goes_here, :receives_people_here => receives_people_here)
    # Add a second classroom half of the time
    if Random.new.rand(0..1) == 0
        teacher.classrooms.create!(:zone_id => Zone.random, :goes_here => goes_here, :receives_people_here => receives_people_here)
    end
    # Add a professorship
    price_per_hour = Random.new.rand(15..50)
    # Set a nil every 1/3 classrooms (approx)
    if Random.new.rand(0..2) == 0
        price_per_hour = nil
    end
    teacher.professorships.create!(:activity_id => activity.id, :price_per_hour => price_per_hour)
    # Random activity?
    random_activities_number.times do
        activity = Activity.random;
        teacher.professorships.create!(:activity_id => activity.id, :price_per_hour => Random.new.rand(15..50))
    end
    # Random rating for the teacher
    Random.new.rand(1..5).times do
        rating = Random.new.rand(1..5)
        user = User.random
        user = User.random while user.has_rated_teacher?(teacher)
        teacher.ratings.create!(:user_id => user.id, :rating => rating, :comment => Faker::Lorem.words(20))
    end
    # Return the name of the new teacher
    {:last_name => last_name, :first_name => first_name}
  end

end