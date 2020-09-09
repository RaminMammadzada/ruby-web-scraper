require_relative '../lib/product'

describe Product do
  let(:product) {Product.new}

  describe '#initialize' do
    it 'should create a product instance' do
      expect(product).to be_an_instance_of Product
    end

    it 'should initiate all instance variables with values equal to nil' do
      expect( product.getProduct.values.all?(nil) ).to eql true
    end
  end

  describe '#getProduct' do
    it 'should return the hash type instance' do
      expect( product.getProduct ).to be_an_instance_of Hash
    end

    it 'should return the hash includes all of the instance variables' do
      instance_variables = [:id, :name, :brand, :normal_price, :last_price, :image, :total_reviews, :total_stars, :url]
      expect( (product.getProduct.keys & instance_variables).size == instance_variables.size ).to eql(true)
    end
  end

end