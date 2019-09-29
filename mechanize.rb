require 'rubygems'
require 'nokogiri'
require 'byebug'
require 'mechanize'

Dir.glob("*.rb") { |f| require_relative f}


class Mechanize
    
    
    def initialize
        
        # @page = self.get('https://oddschecker.com/')
        @findus = Findus.new
        
    end
    
    def update
        
        @findus.val_good_links(@page)
        
    end
    
end




Mechanize.new.get('https://oddschecker.com/')


