class Product
  attr_accessor :id, :name, :brand, :normal_price, :last_price, :image, :total_reviews, :total_stars

  def initialize()
    @id = nil
    @name = nil
    @brand = nil
    @normal_price = nil
    @last_price = nil
    @images = nil
    @amount_bought = nil
    @stars = nil
  end

  def get_product()
    {:id => @id,
     :name => @name,
     :brand => @brand,
     :normal_price => @normal_price,
     :last_price => @last_price,
     :image => @image,
     :total_reviews => @total_reviews,
     :total_stars => @total_stars,
    }
  end

end
