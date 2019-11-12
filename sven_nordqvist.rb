require 'byebug'
require 'pp'
require 'mechanize'

require_relative 'findus.rb'
require_relative 'prillan.rb'
require_relative 'gumman.rb'

#   Handler
#   Ser till att alla funktioner körs och i rätt ordning, samt loopar hämta matcher och odds
#
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
        update_pages(@spider.get_good_links())
    end
    
    
    def update_pages(sports)
        matches = []
        odds = {}
        sports.each do |sport|
            matches << @spider.get_matches(sport)
            sleep(0.03)
        end
        matches.each do |match|
            results = @collector.get_odds(match)
            odds[results[0]] = results[1]
            sleep(0.03)
        end
        update_pages_loop(sports)
    end
    
end


Sven_Nordqvist.new