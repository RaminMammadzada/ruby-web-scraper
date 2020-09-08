require_relative "../lib/scraper.rb"
require_relative "../lib/product.rb"
require 'colorize'
require 'colorized_string'
require 'json'

class CommandLineInterface

  @@BASE_PATH = "https://www.trendyol.com/"

  def run

    interact_with_user()
    make_products
    compare_product_total_reviews()
  end

  def make_products
    Scraper.start_urls << @@BASE_PATH
    Scraper.crawl!
  end

  def interact_with_user()
    puts " This is an application to get the most 5 famous products in the spesific product category from Trendyol.com ".colorize(:color => :red, :background => :black)
    puts " Trendyol.com is one of the well known ecommerce platforms in Turkey. ".colorize(:color => :light_red, :background => :black)
    puts
    puts " Please enter your keyboards to search products: ".colorize(:color => :light_red, :background => :black)
    puts " You must enter keywords in TURKISH only! ".colorize(:color => :light_red, :background => :black)
    puts " Sample input 1: nike siyah erkek ayakkabi ".colorize(:color => :light_red, :background => :black)
    puts " Sample input 2: klavye ".colorize(:color => :light_red, :background => :black)
    puts " Sample input 3: kadin pantolon ".colorize(:color => :red, :background => :black)
    puts
    puts " It is your turn now. Please enter the keywords: ".colorize(:color => :light_red, :background => :black)
    keywords_string = gets.chomp
    keywords_string_cleaned = keywords_string.downcase.split.join('+')

    @@BASE_PATH += keywords_string_cleaned

    puts ""
    puts " You can also specify price interval, like 50-200. It is in TL currency ".colorize(:color => :magenta, :background => :black)
    puts " To decrease the amount of results and to get the answer fast, it is advised.    ".colorize(:color => :magenta, :background => :black)
    puts " Plase enter your price interval or just press enter ".colorize(:color => :magenta, :background => :black)
    price_interval = gets.chomp
    if !price_interval.empty?
      @@BASE_PATH += ( "?fiyat=" + price_interval )
    end
  end

  def compare_product_total_reviews()
    file = File.read('product_search_result.json')
    array_of_product_hashes = JSON.parse(file)

    array_of_product_hashes.sort_by!{ |product_hash| product_hash['total_reviews'].to_i }.reverse!

    puts "TOP REVIEWED 5 PRODUCTS WITH THEIR LINKS:".colorize(:color => :red, :mode => :bold, :background => :black)
    puts "- - - - - - - - - - - - - - - - - - - - -".colorize(:color => :red, :background => :black)
    5.times do |index|
      product_hash = array_of_product_hashes[index]
      puts ( (index + 1).to_s + ") " + "Product name: "  + product_hash['name']).colorize(:color => :green, :mode => :bold, :background => :light_black)
      puts ("   Total reviews: " + product_hash['total_reviews']).to_s.colorize(:color => :green, :mode => :bold, :background => :light_black)
      puts ("   Product URL: " + product_hash['url']).colorize(:color => :green, :mode => :bold, :background => :light_black)
      puts "   - - - - - - -".colorize(:color => :light_yellow, :mode => :bold, :background => :light_black)
    end

  end
end