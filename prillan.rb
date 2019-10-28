require_relative 'gumman.rb'
class Prillan < Mechanize
    
    def initialize
        super
        @gumman = Gumman.new
    end
    
    def get_odds(matches)
        odds = {}
        
        
        matches.each do |match|
            temp_arr = []
            odds_arr = []
            match.search('td.bc.bs').each do |odd|
                temp_arr << odd.children.text
            end 
            long = (temp_arr.length / 2)

            if long > 1
                temp_arr.each_slice(long) {|temp|
                odds_arr << temp}
                if !odds_arr.nil?
                    odds[match.uri] = odds_arr
                    add_odds_db(match.uri, odds_arr)
                end
            end
        end
        
        return odds
        
    end
    
    def add_odds_db(match,odds)        
        @gumman.add_odds_db(match,odds)
    end
    
    
end