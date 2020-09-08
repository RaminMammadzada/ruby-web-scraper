require_relative "../lib/scraper.rb"
require_relative "../lib/product.rb"
require 'colorize'

class CommandLineInterface
  # BASE_PATH = "https://www.trendyol.com/erkek+ayakkabi"
  # BASE_PATH = "https://www.trendyol.com/erkek+casual-ayakkabi/bambi"
  # BASE_PATH = "https://www.trendyol.com/erkek+casual-ayakkabi/bambi?fiyat=0-160"
  # BASE_PATH = "https://www.trendyol.com/erkek+casual-ayakkabi/bambi?fiyat=0-120"
  # BASE_PATH = "https://www.trendyol.com/kadin+pijama/penti"
  # BASE_PATH = "https://www.trendyol.com/kadin+pijama/penti?fiyat=75-80"
  # BASE_PATH = "https://www.trendyol.com/erkek+ayakkabi/puma?fiyat=300-305"
  # BASE_PATH = "https://www.trendyol.com/agda/sesu"
  @@BASE_PATH = "https://www.trendyol.com/"

  def run
    interact_with_user()
    make_products
  end

  def make_products
    Scraper.start_urls << @@BASE_PATH
    Scraper.crawl!
  end

  def interact_with_user()
    p "This is an application to get the most sold 10 products in the spesific product category from Trendyol.com"
    p "Trendyol.com is one of the famous ecommerce platforms in Turkey."
    p ""
    p "Please enter your keyboards to search products:"
    p "You must enter keywords in TURKISH only! "
    p "Sample input 1: nike siyah erkek ayakkabi"
    p "Sample input 2: klavye"
    p "Sample input 3: kadin pantolon"
    p ""
    p "It is your turn now. Please enter the keywords:"
    keywords_string = gets.chomp
    keywords_string_cleaneds = keywords_string.downcase.split.join('+')

    @@BASE_PATH += keywords_string_cleaneds

    p ""
    p "You can also specify price interval, like 50-200. It is in TL currency"
    p "To decrease the amount of results and to get the answer fast, it is advised."
    p "Plase enter your price interval or just press enter"
    price_interval = gets.chomp
    if !price_interval.empty?
      @@BASE_PATH += ( "?fiyat=" + price_interval )
    end
  end
end