# require_relative 'gumman.rb'
require 'mechanize'
# Calculator
# Jämför odds med varandra och beräknar optimalt sätt att satsa pengar
# 
class Muckloman < Mechanize
    def initialize
        super
        odds = {'link0'=>[["2/9", "1/5", "2/9", "6/25", "2/9", "1/5", "2/9", "1/5", "1/5", "11/50", "2/9", "3/14", "2/9", "2/9", "3/14", "2/11", "1/5", "1/5", "3/14", "1/100"], ["3", "29/10", "3", "72/25", "3", "29/10", "11/4", "13/4", "29/10", "14/5", "14/5", "3", "3", "41/13", "3", "3", "13/4", "29/10", "3", "1/50"]], 
                'link1'=>[["9/25", "4/11", "4/11", "7/20", "7/20", "6/17", "6/17", "6/17", "6/19", "17/50", "6/17"], ["51/25", "19/10", "2", "39/20", "39/20", "2", "39/19", "2", "37/19", "39/20", "2"]],
                'link2'=>[["8/13", "13/20", "8/13", "16/25", "13/20", "13/20"], ["6/5", "11/10", "6/5", "6/5", "23/20", "11/10"]], 
                'link3'=>[["1/5", "1/5", "1/5", "2/11"], ["10/3", "10/3", "17/5", "31/10"]], 
                'link4'=>[["1/40", "1/50"], ["19/2", "9"]],
                'link5'=>[["4/7", "4/6", "16/25", "5/7", "5/7", "9/13", "5/7", "5/7"], ["5/4", "11/10", "6/5", "21/20", "11/10", "21/20", "11/10", "11/10"]], 
                'link6'=>[["8/13", "29/50", "4/7", "11/17", "3/5"], ["6/5", "129/100", "5/4", "6/5", "117/100"]], 
                'link7'=>[["1/16", "1/16", "1/16"], ["7", "13/2", "13/2"]], 
                'link8'=>[["7/10", "5/7", "13/17", "5/7", "9/13", "8/11", "5/7"], ["1", "1", "17/16", "1", "1", "1", "1"]], 
                'link9'=>[["1/4", "1/4"], ["13/5", "13/5"]],
                'link10'=>[["22/10","23/10"], ["198/100", "84/50"]]}
        i=0
        hash = {}
        while i < odds.length
            y=0
            link = "link"+i.to_s
            odds_and_bets_collection = []

            while y < odds[link][0].length
                j=0
                odds_and_bets = []

                while j < odds[link][1].length
                    odds_1 = odds[link][0][y]
                    odds_2 = odds[link][1][j]
                    market_margin = (((1.0/Rational(odds_1))*100)+((1.0/Rational(odds_2))*100))
                   
                    if market_margin < 100
                        print"\n"
                        puts "Arbitrage oppurtunity:"
                        puts link + " with " + odds_1.to_s + " and " + odds_2.to_s 
                        puts "Market margin: " + market_margin.round(2).to_s + " %"
                        puts "Om du ska satsa 100 kr:"
                        
                        implied_prob_1 = (1/(Rational(odds_1)) * 100).to_f
                        implied_prob_2 = (1/(Rational(odds_2)) * 100).to_f
                        
                        bet_1 = ((100*implied_prob_1)/market_margin).round(2)
                        bet_2 = ((100*implied_prob_2)/market_margin).round(2)
                        
                        puts odds_1.to_s + ": " + bet_1.to_s + " kr"
                        puts odds_2.to_s + ": " + bet_2.to_s + " kr"
                        
                        odds_and_bets << [odds_1, bet_1]
                        odds_and_bets << [odds_2, bet_2]
                    end
                    j+=1
                end
                if odds_and_bets != []
                    odds_and_bets_collection << odds_and_bets
                end
                y+=1
            end
            hash[link] = odds_and_bets_collection 
            
            # print 
            # print 
            # print"\n"

            i+=1
        end  

        puts hash
        print "\n"
        print hash["link10"]
        # puts odds.length
            # print odds
            # 
        # end
       
        # number=gets.chomp 
        # print odds["link#{number}"][0][0]
        # print "\n"
        # print odds["link#{number}"][1][0]
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