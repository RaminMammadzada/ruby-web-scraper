require 'open-uri'
require 'kimurai'

class Scraper < Kimurai::Base
  @name = "trendyol_spider"
  @engine = :selenium_chrome
  @start_urls = []
  @config = {
      user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
      before_request: { delay: 1..3 }
  }

  def parse(response, url:, data: {})
    counter = 0
    response.xpath("//div[@class='prdct-cntnr-wrppr']/div['p-card-wrppr']").each do |element|

      p "COUNTER:: #{counter}"
      parse_category_page(element)
      counter += 1
    end

  end

  def parse_category_page(product_tag)

    data_id = product_tag.attribute('data-id').value()
    p "Data id: #{data_id}"

    image_url= product_tag.css('.p-card-chldrn-cntnr').css('a').css('div').css('.p-card-img-wr').css('img').attribute('src').value()
    element_b = product_tag.css('.p-card-chldrn-cntnr').css('a').css('div').css('.p-card-img-wr').css('img').attribute('alt').value()


    brand = product_tag.css('.p-card-chldrn-cntnr').css('a').css('.prdct-desc-cntnr-ttl-w').css('.prdct-desc-cntnr-ttl').text
    product_name = product_tag.css('.p-card-chldrn-cntnr').css('a').css('.prdct-desc-cntnr-ttl-w').css('.prdct-desc-cntnr-name').text

    p "Image URL: #{image_url}"
    p "Product name: #{product_name}"
    p "Brand: #{brand}"
    p "+  +  +  +"

  end

  # def self.scrape_product()
  #
  # end

end