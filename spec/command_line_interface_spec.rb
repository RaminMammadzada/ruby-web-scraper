require_relative '../lib/command_line_interface'
require_relative '../lib/scraper'
require 'kimurai'

describe CommandLineInterface do
  let(:cmd_interface) { CommandLineInterface.new }

  describe '#run' do
    it 'after interacting with user,should create products' do
      path = 'https://www.trendyol.com/hp+bilgisayar?fiyat=0-3000'
      CommandLineInterface.set_base_path(path)
      Scraper.set_scroll( false )
      cmd_interface.run
      expect(Scraper.total_product_count).to_not eql 0
    end

    it 'should save products into product_search_result.json file' do
      file_exist_and_filled = !File.size?('product_search_result.json').nil?
      expect(file_exist_and_filled).to eql true
    end
  end
end
