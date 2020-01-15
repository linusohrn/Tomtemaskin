require_relative 'gumman.rb'
require 'mechanize'
require 'pp'
require 'byebug'

test_odds = [
    {:link=>"https://www.oddschecker.com/football/english/premier-league/bournemouth-v-watford/winner", :odds=>[[[["1/18", 46.26], ["1/41", 53.74]], [["55/4", 46.26], ["36", 53.71]]]]},
    {:link=>"https://www.oddschecker.com/football/english/premier-league/watford-v-tottenham/winner", :odds=>[[[["5/2", 46.26], ["13/5", 53.74]], [["12/5", 46.26]]]]}

class Bettson < Mechanize

    def initialize
        Gumman.connect()
        super
    end

    def have_account?(match)

        # TODO: Check if have account
    
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


    def booker_class_profiler(booker_class)

        case booker_class

        when "B3"
            return "Bet365"
        when "SK"
            return "SkyBet"
        when "LD"
            return "Ladbrokes"
        when "WH"
            return "William Hill"
        when "MR"
            return "Marathon Bet"
        when "FB"
            return "Betfair Sportsbook"
        when "VC"
            return "Bet Victor"
        when "PP"
            return "Paddy Power"
        when "UN"
            return "Unibet"
        when "CE"
            return "Coral"
        when "FR"
            return "Betfred"
        when "WA"
            return "Betway"
        when "SA"
            return "Sport Nation"
        when "BY"
            return "Boyle Sports"
        when "VT"
            return "VBet"
        when "OE"
            return "10Bet"
        when "SO"
            return "Sportingbet"
        when "EE"
            return "888sport"
        when "YP"
            return "MoPlay"
        when "SX"
            return "Spreadex"
        when "RZ"
            return "Redzone"
        when "BF"
            return "Betfair"
        when "BD"
            return "Betdaq"
        when "MA"
            return "Matchbook"
        when "MK"
            return "Smarkets"

        end

    end
            

    
    def main(arb_odds)
        handled_total_data = handle_data(arb_odds)

        match_nr = 0
        handled_total_data.each do |match|
            
            match = handled_total_data[match_nr]
            match_page = get(match[:location])

            puts "Match #{match_nr+1}: at #{match[:location]}"
            # class: diff-row evTabRow bc

            # No clue how .search works
            
            match[:odds].each do |odd|
                
                # Currently searches through entire mechanize page object which is quite slow 
                # TODO: make sure it doesn't do that ^
                # Attribute name of odds class: "data-o"
                odd_node = match_page_noko.attr_equals("data-o", odd)

                # Could probably be solved better with exceptions
                if odd_node.length > 0

                    # Attribute name of booker class: "data-bk"
                    booker_class = odd_node.attribute("data-bk").value
                puts "#{odd_nr}: #{match_page.body.include?(odd)}"
                puts "#{odd_nr}: #{odd} at booker class: #{booker_class}"

                # Associate booker_class with actual booker
                puts booker_class_profiler(booker_class)


                odd_nr += 1

            end

                #TODO: associate each found odd with booker

            end


            match_nr += 1
            puts "------------------------------"


        end



    end

end

@better = Bettson.new
@better.main(new_test_odds)