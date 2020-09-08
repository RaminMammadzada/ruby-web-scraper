require_relative "../lib/scraper.rb"
require_relative "../lib/product.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInterface
  # BASE_PATH = "https://www.trendyol.com/erkek+ayakkabi"
  # BASE_PATH = "https://www.trendyol.com/erkek+casual-ayakkabi/bambi"
  # BASE_PATH = "https://www.trendyol.com/erkek+casual-ayakkabi/bambi?fiyat=0-160"
  BASE_PATH = "https://www.trendyol.com/erkek+casual-ayakkabi/bambi?fiyat=0-120"


  def run
    make_products
    # add_attributes_to_products
    # display_products
  end

  def make_products
    Scraper.start_urls << BASE_PATH
    Scraper.crawl!
  end
end