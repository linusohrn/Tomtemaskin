require_relative 'gumman.rb'
#   Collector
#   Hämtar oddsen från sidorna
#   
class Prillan < Mechanize
    
    def initialize
        super
        @gumman = Gumman.new
    end
    
    def get_odds(match)
        odds = {}
        temp_arr = []
        odds_arr = []
        # match = get(match)
        match.search('td.bc.bs').each do |odd|
            temp_arr << odd.children.text
        end 
        long = (temp_arr.length / 2)
        
        if long > 1
            temp_arr.each_slice(long) {|temp|
            odds_arr << temp}
            if !odds_arr.nil?
                odds_arr
                add_odds_db(match.uri, odds_arr)
            end
        end
        return match, odds
    end
    
    
    def add_odds_db(match,odds)        
        @gumman.add_odds_db(match,odds)
    end
    
end