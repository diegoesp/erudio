class Category

  attr_accessor :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.get_random_categories
    @cat1 = Category.new 1, "Guitarra"
    @cat2 = Category.new 2, "Piano"
    @cat3 = Category.new 3, "Ingles"
    @cat4 = Category.new 4, "Fisica"
    @cat5 = Category.new 5, "Matematicas"

    @categories = [@cat1, @cat2, @cat3, @cat4, @cat5]
  end
end