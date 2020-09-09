require 'open-uri'
require 'kimurai'
require_relative '../lib/product'

class Scraper < Kimurai::Base

  @name = "trendyol_spider"
  @engine = :selenium_chrome
  @start_urls = []
  # @config = {
  #     user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
  #     before_request: { delay: 1..3 }
  # }

  @@all_products = []
  @@counter = 0
  def parse(response, url:, data: {})
    products_info_path = "//div[@class='prdct-cntnr-wrppr']/div['p-card-wrppr']"
    count = response.xpath(products_info_path).count

    if count == 0
      puts "There is no match for the keyword or price range you typed!".colorize(:color => :red, :background => :black)
      puts "You should run the app again and check your chance one more time!".colorize(:color => :red, :background => :black)
      exit
    end

    last_response = scroll_down_and_get_response(products_info_path, count)
    fill_products(last_response, products_info_path)

  end

  def scroll_down_and_get_response(products_info_path, count)
    puts "..:: The scrolling down in the Single Page App is started ::..".colorize(:color => :light_red)
    puts "..:: Please wait now, it may take a few minutes to finish ::..".colorize(:color => :light_red)
    response = ''
    loop do
      8.times {browser.execute_script("window.scrollBy(0,500)") ; sleep 1}
      response = browser.current_response

      new_count = response.xpath(products_info_path).count
      if count == new_count
        logger.info "> Pagination is done" and break
      else
        count = new_count
        logger.info "> Continue scrolling, current count is #{count}..."
      end
    end

    response
  end

  def fill_products(response, products_info_path)
    sleep 2
    response.xpath(products_info_path).each do |element|
      @@counter += 1
      @@all_products << parse_product_path(element)
      p ">>>>COUNTER: #{@@counter}"
    end
  end

  def parse_product_path(product_path)

    product = Product.new

    product.id = product_path.attribute('data-id').value()

    product_path_focused =  product_path.css('.p-card-chldrn-cntnr').css('a')

    product.image = product_path_focused.css('div').css('.p-card-img-wr').css('img').attribute('src').value()

    product.brand = product_path_focused.css('.prdct-desc-cntnr-ttl-w').css('.prdct-desc-cntnr-ttl').text

    product.name = product_path_focused.css('.prdct-desc-cntnr-ttl-w').css('.prdct-desc-cntnr-name').text

    product.total_stars, product.total_reviews = add_product_stars_and_reviews(product_path_focused)

    product_normal_price = product_path_focused.css('.prc-cntnr').css('.prc-box-sllng-w-dscntd').text
    product_normal_price = product_path_focused.css('.prc-cntnr').css('.prc-box-orgnl').text if product_normal_price == ''
    product.normal_price = product_normal_price

    product_last_price = product_path_focused.css('.prmtn-cntnr').css('.prc-box-dscntd').text
    product_last_price = product_path_focused.css('.prmtn-cntnr').css('.prc-box-sllng').text if product_last_price == ''
    product_last_price = product_path_focused.css('.prc-cntnr').css('.prc-box-sllng').text if product_last_price == ''
    product_last_price = product_path_focused.css('.price-promotion-container').css('.prc-box-dscntd').text if product_last_price == ''
    product.last_price = product_last_price

    product_url = product_path_focused.attribute('href').value
    product.url = "https://www.trendyol.com" + product_url

    save_to "product_search_result.json", product.get_product, format: :pretty_json
    product
  end

  def add_product_stars_and_reviews(product_path_focused)
    product_stars_path = product_path_focused.css('.ratings').css('.star-w')
    if product_stars_path.to_s != ''
      product_total_stars = (0..4).inject do |total, num|
        total + product_stars_path[num].css('.full').attribute('style').value()[6..9].to_i
      end
      product_total_stars = ( product_total_stars + 100 ) / 100.00

      product_total_reviews = product_path_focused.css('.ratings').css('.ratingCount').text
      product_total_reviews = product_total_reviews[1..-2]
    else
      product_total_stars = 0
      product_total_reviews = "0"
    end
    [product_total_stars, product_total_reviews]
  end
end