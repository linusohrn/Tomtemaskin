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
    
    
    def stuff(arb_odds)
        
        i = 0
        arb_odds.each do |match|
            # usch fyfan vad jag hatar det allt jag har skrivit här
            url = match.values[0]
            page = self.get(url)

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
            end
            
            # Här sker skit för varje match
            
            odds.each do |odd|
                
                if page.search(odd) != nil
                    puts "Found #{odd}"
                end
            end


            #TODO: hitta sätt att associera givet odd med sida den kommer från
            
            
            
            
            
            
            
            
            
            
            # puts i
            # puts "----------------------------------"



        end


    end

end

# p test_odds[0].values[1][0][0][0][0]

@better = Bettson.new
@better.stuff(test_odds)