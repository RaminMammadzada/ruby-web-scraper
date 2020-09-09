class Product
  attr_accessor :id, :name, :brand, :normal_price, :last_price, :image, :total_reviews, :total_stars, :url

  def initialize()
    @id = nil
    @name = nil
    @brand = nil
    @normal_price = nil
    @last_price = nil
    @image = nil
    @total_reviews = nil
    @total_stars = nil
    @url = nil
  end

  def getProduct()
    {:id => @id,
     :name => @name,
     :brand => @brand,
     :normal_price => @normal_price,
     :last_price => @last_price,
     :image => @image,
     :total_reviews => @total_reviews,
     :total_stars => @total_stars,
     :url => @url
    }
  end
end
