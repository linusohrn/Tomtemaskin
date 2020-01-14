require_relative 'gumman.rb'

class Prillan
    
    def initialize
        
        Gumman.connect()
        @wallet ||= 100
    end

    
    def fake_match(odds_and_profit)
        team1 = odds_and_profit[0][0].to_r
        team2 = odds_and_profit[1][0].to_r
        
        team1prof = odds_and_profit[0][1]
        team2prof = odds_and_profit[1][1]
        
        prob1 = 1 - team1/10
        prob2 = 1 - team2/10
        randint = rand()
        # p prob1.to_f
        # p randint
        # p prob2.to_f
        
        if randint >= prob1
            # p "team1"
            add_balance(team1prof)
        elsif randint <= prob2
            # p "team2" 
            add_balance(team2prof)
        end
    end
    
    def calculate_profit(odds_and_bet)
        # p odds_and_bet
        if !odds_and_bet.nil? && !odds_and_bet.empty?
            # p "ran"
            odds_and_bet = odds_and_bet.values
            potential = []
            odds_and_bet.each_with_index do |team, index|
                temp = []
                temp << team[0]
                temp << ((team[0].to_i * team[1].to_i) + team[1].to_i)
                
                potential << temp
                
            end
            p potential
            return potential
        end
    end
    
    
    def current_balance?
        return @wallet
    end
    
    def add_balance(money)
        @wallet += money.to_i
    end
    
    def log
        Gumman.log_balance(Time.now, current_balance?())
    end
end
