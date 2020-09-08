require_relative "../lib/scraper.rb"
require_relative "../lib/product.rb"
require 'colorize'

class CommandLineInterface
  # BASE_PATH = "https://www.trendyol.com/erkek+ayakkabi"
  # BASE_PATH = "https://www.trendyol.com/erkek+casual-ayakkabi/bambi"
  # BASE_PATH = "https://www.trendyol.com/erkek+casual-ayakkabi/bambi?fiyat=0-160"
  # BASE_PATH = "https://www.trendyol.com/erkek+casual-ayakkabi/bambi?fiyat=0-120"
  BASE_PATH = "https://www.trendyol.com/kadin+pijama/penti"
  # BASE_PATH = "https://www.trendyol.com/kadin+pijama/penti?fiyat=75-80"


  def run
    make_products
  end

  def make_products
    Scraper.start_urls << BASE_PATH
    Scraper.crawl!
  end
end