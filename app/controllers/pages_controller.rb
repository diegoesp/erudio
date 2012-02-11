class PagesController < ApplicationController

  protect_from_forgery

  respond_to :json
  respond_to :html

  def home
    @json_init = '{"id":"1","name":"Piano"},{"id":"2","name":"Bateria"},{"id":"3","name":"Guitarra"},{"id":"4","name":"Ingles"},{"id":"4","name":"Fisica"},{"id":"5","name":"Petear"},{"id": "6", "name": "Actividad 1"}'
  end

  def categories
    @categories = Category.get_random_categories
    respond_with(@categories)
  end
end
