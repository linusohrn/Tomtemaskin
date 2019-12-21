require_relative 'gumman.rb'
require 'mechanize'
require 'pp'
require 'byebug'

old_test_odds = [
{:link=>"https://www.oddschecker.com/golf/tournament-matches-specials/18-hole-matches/robby-shelton-v-harris-english/mythical-2-balls", :odds=>[[[["23/10", 46.26], ["198/100", 53.74]], [["21/10", 46.26], ["197/100", 53.71]]]]},
{:link=>"https://www.oddschecker.com/football/english/fa-cup/solihull-moors-v-rotherham/winner", :odds=>[[[["24/10", 46.27], ["199/100", 53.33]], [["27/10", 46.3]]]]}
]

new_test_odds = [
    {:link=>"https://www.oddschecker.com/football/france/ligue-1/dijon-v-metz/winner", :odds=>[[[["6/5", 46.26], ["13/5", 53.74]], [["14/5", 46.26], ["109/50", 53.71]]]]},
    {:link=>"https://www.oddschecker.com/football/france/ligue-1/reims-v-lyon/winner", :odds=>[[[["2/5", 46.26], ["21/5", 53.74]], [["5", 46.26]]]]}
]

class Bettson < Mechanize

    def initialize
        Gumman.connect()
        super
    end
    
    def have_account?(match)

        # TODO: Check if have account
    
    end
    
    # Reworks the way the data is processed so it's easier to work in within mechanize.
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
                
                
                handled_match_data = {:match_nr => i,
                                    :location => location,
                                    :odds => odds,
                                    :bets => bets}

                handled_total_data.push(handled_match_data)
                
                # Test shit might be useful

                # puts ""
                # puts "Match #{i}:"
                # puts "Location: #{location}"
                # puts "Odds: #{odds}"
                # puts "Bets: #{bets}"
                # puts ""
                # puts "Added Match #{i} to handled_total_data"
                # puts "------------------------------------"

                i += 1
            end

        end

        return handled_total_data

    end

    
    def main(arb_odds)
        handled_total_data = handle_data(arb_odds)

        match_nr = 0
        handled_total_data.each do |match|
            
            match = handled_total_data[match_nr]
            match_page = get(match[:location])

            # class: diff-row evTabRow bc

            # No clue how .search works
            
            odd_nr= 1
            match[:odds].each do |odd|
                
                # Currently searches through entire mechanize page object which is quite slow 
                # TODO: make sure it doesn't do that ^

                puts "#{odd_nr}: #{match_page.body.include?(odd)}"

                odd_nr += 1

                #TODO: associate each found odd with booker

            end


            match_nr += 1
            puts "------------------------------"


        end



    end

end

@better = Bettson.new
@better.main(new_test_odds)