require 'byebug'
require 'pp'
require 'mechanize'

require_relative 'findus.rb'
require_relative 'prillan.rb'
require_relative 'gumman.rb'
require_relative 'muckloman.rb'

#   Handler
#   Ser till att alla funktioner körs och i rätt ordning, samt loopar hämta matcher och odds
#
class Sven_Nordqvist
    
    def initialize
        @running = true
        system("cls")
        @spider = Findus.new
        @calculator = Muckloman.new
        Gumman.db_setup()
        startup()
    end
    
    
    def update_loop
        while @running
            puts "looped"
            puts "Took #{Time.now - @starttime}"
            sleep(3600)
            startup()
        end
    end
    
    def startup
        @starttime = Time.now
        update_sports()
        update_loop()
    end

    def update_sports 
        @spider.get_good_links.each do |sport|
            update_pages(sport)
            sleep(0.03)
        end
    end
    
    
    def update_pages(sport)
        update_matches(@spider.get_matches(sport))
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
        # puts odds
        arbitrage_odds = @calculator.get_arbitrage_odds(odds)
        # puts arbitrage_odds
        # puts "sport finished"
    end

    def update_odds(match)
        
        return (@spider.get_odds(match))
        
    end
    
end

Sven_Nordqvist.new

