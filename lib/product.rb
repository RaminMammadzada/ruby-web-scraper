class Product
  attr_accessor :id, :name, :brand, :normal_price, :last_price, :image, :total_review, :total_stars

  @@all = []

  def initialize(product_hash)
    product_hash.each do |attribute, value|
      self.send("#{attribute}", value)
    end
    @all << self
  end

  def self.create_from_collection(products_array)
    products_array.each do |product_hash|
      Product.new(product_hash)
    end
  end

  def add_product_attributes(attributes_hash)
    attributes_hash.each do |attr, value|
      self.send("#{attr}", value)
    end
    self
  end

  def self.all
    @@all
  end

end
