require_relative 'gumman.rb'
require 'mechanize'
require 'pp'
require 'byebug'

test_odds = [
{:link=>"https://www.oddschecker.com/golf/tournament-matches-specials/18-hole-matches/robby-shelton-v-harris-english/mythical-2-balls", :odds=>[[[["23/10", 46.26], ["198/100", 53.74]], [["21/10", 46.26], ["197/100", 53.71]]]]},
{:link=>"https://www.oddschecker.com/football/english/fa-cup/solihull-moors-v-rotherham/winner", :odds=>[[[["24/10", 46.27], ["199/100", 53.33]], [["27/10", 46.3]]]]}
]

class Bettson < Mechanize

    def initialize
        Gumman.connect()
        super
    end
    
    # Betslip är ett skämt, är inaktiverad för typ alla sporter
    # Måste skapa ett system som skapar konton
    # VARFÖR KAN INTE BETSLIP BARA FUNGERA
    
    def have_account?(match)

        # skriv någon gång
    
    end
    

    def handle_data(arb_odds)

        handled_total_data = []
        
        i = 1
        arb_odds.each do |match|

            
            location = match[:link]
            page = self.get(location)
            
            odds_and_bet = match.values[1]
            odds = []
            bets = []   
            
            odds_and_bet.each do |thingy|
                thingy.each do |thingy2|                
                    thingy2.each do |thingy3|
                        odds.push(thingy3[0])
                        bets.push(thingy3[1])
                    end
                end 
                
                
                handled_match_data = {:matchnr => i,
                                    :location => location,
                                    :odds => odds,
                                    :bets => bets}

                handled_total_data.push(handled_match_data)
                
                puts ""
                puts "Match #{i}:"
                puts "Location: #{location}"
                puts "Odds: #{odds}"
                puts "Bets: #{bets}"
                puts ""
                puts "Added Match #{i} to handled_total_data"
                puts "------------------------------------"




                i += 1
            end

        end
    end

    
    def main(arb_odds)
        handle_data(arb_odds)



    end

end

@better = Bettson.new
@better.main(test_odds)