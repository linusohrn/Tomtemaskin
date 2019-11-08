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
        odds = update_sports()
        update_loop()
    end

    def update_sports
        sports = @spider.get_good_links
        sports.each do |sport|
            update_pages(sport)
            sleep(0.03)
        end
    end
    
    
    def update_pages(sports)
        matches = @spider.get_matches(sport)
        update_matches(matches)
    end

    def update_matches(matches)
        
        odds={}
        if !matches.nil?
            matches.each do |match|
                
                results = update_odds(match)
                odds[results[0]] = results[1]
                sleep(0.03)
            end
        end
    end

    def update_odds(match)
        
        return (@collector.get_odds(match))
        
    end
    
end


Sven_Nordqvist.new