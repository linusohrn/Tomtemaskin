# require_relative 'gumman.rb'
require 'mechanize'
require 'pp'
# Calculator
# Jämför odds med varandra och beräknar optimalt sätt att satsa pengar
# 
class Muckloman < Mechanize
    def initialize
        super
    end
    
    def get_arbitrage_odds(odds)
        hash = {}
        # puts odds
        # puts odds.class
        odds.each do |key, value|
            odds_and_bets_collection = []
            # puts "Key:" + key.to_ss
            # puts "Value:" + value.to_s
            duplicate_check1 = []

            if value[0] != nil
            value[0].each do |odds_team1|
                odds_and_bets = []
                
                if duplicate_check1.include?(odds_team1) == false
                
                    duplicate_check1 << odds_team1
                    duplicate_check2 = []

                    value[1].each do |odds_team2|
                        if duplicate_check2.include?(odds_team2) == false
                            
                            duplicate_check2 << odds_team2
                            
                            market_margin = (((1.0/Rational(odds_team1))*100)+((1.0/Rational(odds_team2))*100))  
                            
                            puts "Game: " + key.to_s
                            puts "Odds: " + odds_team1.to_s + ", " + odds_team2.to_s           

                            if market_margin < 100
                                puts "Arbitrage oppurtunity:"
                                puts key.to_s + " with " + odds_team1.to_s + " and " + odds_team2.to_s 
                                puts "Market margin: " + market_margin.round(2).to_s + " %"
                                puts "Om du ska satsa 100 kr:"
                                
                                implied_prob_1 = (1/(Rational(odds_team1)) * 100).to_f
                                implied_prob_2 = (1/(Rational(odds_team2)) * 100).to_f
                                
                                bet_1 = ((100*implied_prob_1)/market_margin).round(2)
                                bet_2 = ((100*implied_prob_2)/market_margin).round(2)
                                
                                puts odds_team1.to_s + ": " + bet_1.to_s + " kr"
                                puts odds_team2.to_s + ": " + bet_2.to_s + " kr"
                                
                                odds_and_bets << [odds_team1, bet_1]
                                odds_and_bets << [odds_team2, bet_2]
                            end
                        end
                    end
                end
    
                if odds_and_bets != []
                    odds_and_bets_collection << odds_and_bets
                end
    
            end
            end
            if odds_and_bets_collection != []
                hash[key] = odds_and_bets_collection 
            end
    
        end  

        # print "\n"
        # puts hash
        # print "\n"
        
        return hash

    end
end

Muckloman.new

# 
# EXEMPELDATA
#
# ARBITRAGE OPP
# {LÄNK=>[["ODDS1 i fraktion", Kr som ska satsas på ODDS1 i decimaltal], [["ODDS2 i fraktion", Kr som ska satsas på ODDS2 i decimaltal]]
# {#<URI::HTTPS https://www.oddschecker.com/golf/tournament-matches-specials/18-hole-matches/joaquin-niemann-v-sungjae-im/mythical-2-balls>=>[]}, 

# INGEN ARBITRAGE OPP
# {LÄNK=>[]}
# {#<URI::HTTPS https://www.oddschecker.com/golf/tournament-matches-specials/18-hole-matches/robby-shelton-v-harris-english/mythical-2-balls>=>[["23/10", 46.26], ["198/100", 53.74]]}

# TVÅ ARBITRAGE OPPS I EN LÄNK:
# {LÄNK=>[[[ODDS1], [ODDS2]], [[ODDS1], [ODDS2]]]}
# {#<URI::HTTPS https://www.oddschecker.com/snooker/northern-ireland-open/scott-donaldson-v-alfie-burden/winner>=>[[["22/10", 47.37], ["198/100", 52.63]], [["23/10", 46.26], ["198/100", 53.74]]]}
#
# LÅNG HASH
# {#<URI::HTTPS https://www.oddschecker.com/golf/tournament-matches-specials/18-hole-matches/robby-shelton-v-harris-english/mythical-2-balls>=>[["23/10", 46.26], ["198/100", 53.74]], #<URI::HTTPS https://www.oddschecker.com/golf/tournament-matches-specials/18-hole-matches/robby-shelton-v-harris-english/mythical-2-balls>=>[["23/10", 46.26], ["198/100", 53.74]]}