require_relative '../lib/scraper'
require 'nokogiri'

describe Scraper do
  let(:scraper) {Scraper.new}

  describe '#parse' do
    it 'should start parsing and update the total product count after finishing' do
      path= "https://www.trendyol.com/hp+bilgisayar?fiyat=0-5000"
      Scraper.start_urls << path
      Scraper.crawl!
      expect(Scraper.total_product_count).to_not eql 0
    end

    it 'total product count should be 0 when there is no product found related to the keyboards or price range given' do
      path= "https://www.trendyol.com/hp+bilgisayar+elma?fiyat=0-1000"
      Scraper.start_urls << path
      Scraper.crawl!
      expect(Scraper.total_product_count).to eql 0
    end
  end
end