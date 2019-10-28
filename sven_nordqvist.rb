require 'byebug'
require 'pp'
require 'mechanize'

require_relative 'findus.rb'
require_relative 'prillan.rb'
require_relative 'gumman.rb'

class Sven_Nordqvist
    
    def initialize
        @running = true
        system("cls")
        @spider = Findus.new
        @collector = Prillan.new
        Gumman.new.db_setup()
        startup()
    end
    
    
    def update_pages_loop(sports)
        while @running
            puts "looped"
            sleep(3600)
            update_pages(sports)
        end
    end
    
    def startup
        sports = @spider.get_good_links
        update_pages(sports)
    end
    
    
    def update_pages(sports)
        
        matches = @spider.get_matches(sports)
        odds = @collector.get_odds(matches)
        update_pages_loop(sports)
    end
    
end


Sven_Nordqvist.new