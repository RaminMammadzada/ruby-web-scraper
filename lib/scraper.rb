require 'open-uri'
require 'kimurai'
require_relative '../lib/product'
require 'colorize'
require 'colorized_string'

# rubocop:disable Style/ClassVars, Style/GuardClause, Lint/UnusedMethodArgument
class Scraper < Kimurai::Base
  attr_accessor :start_urls

  @name = 'trendyol_spider'
  @engine = :selenium_chrome
  @start_urls = []
  @config = {
      user_agent: "Chrome/68.0.3440.84"
  }

  @@all_products = []
  @@total_product_count = 0
  @@scroll = true

  def parse(response, url:, data: {})
    products_info_path = "//div[@class='prdct-cntnr-wrppr']/div['p-card-wrppr']"
    @@total_product_count = response.xpath(products_info_path).count

    if @@total_product_count.zero?
      puts 'There is no match for the keyword or price range you typed!'.colorize(color: :red, background: :black)
      puts 'You should run the app again and check your chance one more time!'.colorize(color: :red, background: :black)
      exit
    end

    scroll_cond = @@scroll == true
    last_response = scroll_cond ? scroll_down_and_get_response(products_info_path) : response.xpath(products_info_path)
    fill_products(last_response, products_info_path)
  end

  def self.total_product_count
    @@total_product_count
  end

  def self.scroll(value)
    @@scroll = value
  end

  private

  def scroll_down_and_get_response(products_info_path)
    puts '..:: The scrolling down in the Single Page App is started ::..'.colorize(color: :light_red)
    puts '..:: Please wait now, it may take a few minutes to finish ::..'.colorize(color: :light_red)
    response = ''

    loop do
      8.times do
        browser.execute_script('window.scrollBy(0,500)')
        sleep 1
      end
      response = browser.current_response
      new_count = response.xpath(products_info_path).count
      if @@total_product_count == new_count
        logger.info '> Pagination is done' and break
      else
        @@total_product_count = new_count
        logger.info "> Continue scrolling, current count is #{@@total_product_count}..."
      end
    end

    response
  end

  def fill_products(response, products_info_path)
    sleep 2
    response.xpath(products_info_path).each do |element|
      @@all_products << parse_product_path(element)
    end
    puts ">> TOTAL PRODUCTS FETCHED: #{@@all_products.count}".colorize(color: :light_red)
  end

  def parse_product_path(product_path)
    product = Product.new

    product.id = product_path.attribute('data-id').value

    product_path_focused = product_path.css('.p-card-chldrn-cntnr').css('a')

    product.image = product_path_focused.css('div').css('.p-card-img-wr').css('img').attribute('src').value

    product.brand = product_path_focused.css('.prdct-desc-cntnr-ttl-w').css('.prdct-desc-cntnr-ttl').text

    product.name = product_path_focused.css('.prdct-desc-cntnr-ttl-w').css('.prdct-desc-cntnr-name').text

    product.total_stars, product.total_reviews = add_product_stars_and_reviews(product_path_focused)

    product.normal_price, product.last_price = add_normal_and_last_price(product_path_focused)

    product_url = product_path_focused.attribute('href').value
    product.url = 'https://www.trendyol.com' + product_url

    save_to 'product_search_result.json', product.product, format: :pretty_json
    product
  end

  def add_product_stars_and_reviews(product_path_focused)
    product_stars_path = product_path_focused.css('.ratings').css('.star-w')
    if product_stars_path.to_s != ''
      product_total_stars = (0..4).inject do |total, num|
        total + product_stars_path[num].css('.full').attribute('style').value[6..9].to_i
      end
      product_total_stars = (product_total_stars + 100) / 100.00

      product_total_reviews = product_path_focused.css('.ratings').css('.ratingCount').text
      product_total_reviews = product_total_reviews[1..-2]
    else
      product_total_stars = 0
      product_total_reviews = '0'
    end
    [product_total_stars, product_total_reviews]
  end

  def add_normal_and_last_price(product_path_focused)
    product_normal_price = product_path_focused.css('.prc-cntnr').css('.prc-box-sllng-w-dscntd').text
    if product_normal_price == ''
      product_normal_price = product_path_focused.css('.prc-cntnr').css('.prc-box-orgnl').text
    end

    product_last_price = product_path_focused.css('.prmtn-cntnr').css('.prc-box-dscntd').text
    product_last_price = product_path_focused.css('.prmtn-cntnr').css('.prc-box-sllng').text if product_last_price == ''
    product_last_price = product_path_focused.css('.prc-cntnr').css('.prc-box-sllng').text if product_last_price == ''
    if product_last_price == ''
      product_last_price = product_path_focused.css('.price-promotion-container').css('.prc-box-dscntd').text
    end
    [product_normal_price, product_last_price]
  end
end
# rubocop:enable Style/ClassVars, Style/GuardClause, Lint/UnusedMethodArgument
