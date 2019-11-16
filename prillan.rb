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
        match = get(match)
        temp_arr = []
        odds_arr = []
        if match.search('tr.andicap-participant').length <= 2
            match.search('td.bc.bs').each do |odd|
                
                # Remove whitespace
                odd_children = odd.children.text.gsub(/\s+/, "")
                
                if odd_children.empty? == false
                    
                    # Make into fraction
                    if odd_children.include?("/") == false
                        odd_children+="/1"
                    end
                    
                    temp_arr << odd_children
                    
                    
                end
            end
            
            long = (temp_arr.length / 2)
            if long > 1
                temp_i = 0
                if temp_arr.length%2==0
                    odds_arr << temp_arr.pop(long)
                    odds_arr << temp_arr
                end
                
                if odds_arr.length > 1
                    add_odds_db(match.uri, odds_arr)
                end
            end
            
            return match.uri, odds_arr
            
        end  
    end
    
    
    def add_odds_db(match,odds)        
        @gumman.add_odds_db(match,odds)
    end
    
end