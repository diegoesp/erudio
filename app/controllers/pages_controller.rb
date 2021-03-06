# -*- encoding : utf-8 -*-
# Controller that works with general purpose pages (home, about us) and most importantly with the wizard flow!
# Sets initial contexts and provides APIs for associated pages
class PagesController < ApplicationController

  respond_to :json, :html
  skip_before_filter :require_login, :only => [:result, :result_search, :api_caller]

  # Shows the old mock result page. DEPRECATED. Do not use
  # @deprecated
  def result
    @json_result = '{"activity":"Teatro","description":"Lorem ipsum dolum","lastName":"Chiti","name":"Rafael","phone":"46595841","price":"$ 45","stars":"2","tags":["Musico","Rockstar"]},{"activity":"Guitarra","description":"Lorem ipsum dolum","lastName":"Espada","name":"Diego","phone":"46577654","price":"$ 65","stars":"3","tags":["Rockstar","Loquito lindo","Tag very very long"]},{"activity":"Piano","description":"Lorem ipsum dolum","lastName":"Pochiero","name":"Octavio","phone":"45678723","price":"$ 66","stars":"5","tags":["Piano"]},{"activity":"Saxo","description":"Lorem ipsum dolum","lastName":"Rodriguez","name":"Pedro","phone":"47656789","price":"$ 10","stars":"4","tags":["I dont know what to write", "asdasdasd","asdasdasdas","asdadasd"]}'
  end

  # Old API call for the mock result page. DEPRECATED. Do not use. Will be replaced shortly
  # @deprecated
  def result_search

    @json_result = ""

    activities = ["Teatro", "Guitarra", "Matematica"]
    descriptions = ["Profesor con 15 anos de experiencia en la materia designada. Prefiere alumnos en fase universitaria. Excelentes conocimientos generales", "Profesora de primaria y secundaria, prefiere trabajar con chicos de entre 5 y 12 anos. Disponible en zona Norte", "Guitarrista profesional por los ultimos 10 anos, egresado del conservatorio de Buenos Aires. Fanatico de los Beatles."]
    first_names = ["Rafael", "Octavio", "Diego"]
    last_names = ["Espada", "Chiti", "Pochiero"]
    phones = ["4003-3002", "2001-2001", "9999-3991"]
    prices = [20, 30, 60]
    stars = [1, 2, 3]
    tags = ["rockstar", "falopero", "vicioso", "barrial", "creativo", "jeropa", "genio", "geek", "nerd", "salame"]

    for i in 0..8
      random_number = Random.new.rand(0..2)
      activity = activities[random_number]
      random_number = Random.new.rand(0..2)
      description = descriptions[random_number]
      random_number = Random.new.rand(0..2)
      first_name = first_names[random_number]
      random_number = Random.new.rand(0..2)
      last_name = last_names[random_number]
      random_number = Random.new.rand(0..2)
      phone = phones[random_number]
      random_number = Random.new.rand(0..2)
      price = prices[random_number].to_s
      random_number = Random.new.rand(0..2)
      star = stars[random_number].to_s
      random_number = Random.new.rand(0..9)
      tag1 = tags[random_number]
      random_number = Random.new.rand(0..9)
      tag2 = tags[random_number]
      random_number = Random.new.rand(0..9)
      tag3 = tags[random_number]

      if @json_result != ""
        @json_result = @json_result + ","
      end
      @json_result = @json_result + '{"activity":"' + activity + '","description":"' + description + '","lastName":"' + last_name + '","name":"' + first_name + '","phone":"' + phone + '","price":"' + price + '","stars":"' + star + '","tags":["' + tag1 + '","' + tag2 + '","' + tag3 + '"]}'

    end

    @json_result = "[" + @json_result + "]"

    respond_with(@json_result)
  end

  # Displays the API caller testing page
  def api_caller
  end

end
