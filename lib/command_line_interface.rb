require_relative "../lib/scraper.rb"
require_relative "../lib/product.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInterface
  # BASE_PATH = "https://www.trendyol.com/erkek+ayakkabi"
  BASE_PATH = "https://www.trendyol.com/erkek+casual-ayakkabi/bambi"

  def run
    make_products
    # add_attributes_to_products
    # display_products
  end

  def make_products
    Scraper.start_urls << BASE_PATH
    Scraper.crawl!
    # students_array = Scraper.scrape_category_page(BASE_PATH)
    # Product.create_from_collection(students_array)
  end

  def add_attributes_to_products
    # Product.all.each do |product|
    #   attributes = Scraper.scrape_profile_page(BASE_PATH + product.profile_url)
    #   product.add_product_attributes(attributes)
    # end
  end

  def display_products
    # Product.all.each do |product|
    #   puts "#{product.name.upcase}".colorize(:blue)
    #   puts "  location:".colorize(:light_blue) + " #{student.location}"
    #   puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}"
    #   puts "  bio:".colorize(:light_blue) + " #{student.bio}"
    #   puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
    #   puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
    #   puts "  github:".colorize(:light_blue) + " #{student.github}"
    #   puts "  blog:".colorize(:light_blue) + " #{student.blog}"
    #   puts "----------------------".colorize(:green)
    # end
  end

end