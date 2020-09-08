class Product
  attr_accessor :name, :brand, :normal_price, :last_price, :images, :amount_bought, :stars

  @@all = []

  def initialize(product_hash)
    product_hash.each do |attribute, value|
      self.send("#{attribute}", value)
    end


    @name = ''
    @brand = ''
    @normal_price = ''
    @last_price = ''
    @images = ''
    @amount_bought = ''
    @stars = ''

    @all << self
  end

  # def get_product()
  #   {:name => @name,
  #    :brand => @brand,
  #    :normal_price => @normal_price,
  #    :last_price => @last_price,
  #    :images => @images,
  #    :amount_bought => @amount_bought,
  #    :stars => @stars }
  # end

  def self.create_from_collection(products_array)
    products_array.each do |product_hash|
      Product.new(product_hash)
    end
  end

  def add_product_attributes(attributes_hash)
    attributes_hash.each do |attr, value|
      self.send("#{attr}", value)
    end
  end

  def self.all
    @@all
  end

end
