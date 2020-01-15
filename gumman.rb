require 'sqlite3'
#   Databashanterare
#   Lägger till alla fetches och matcher med odds databasen
#   
class Gumman

    def self.connect
        @db = SQLite3::Database.new('db/data.db')
    end

    def self.add_fetch_db(link, deltatime)
        @db.execute('INSERT INTO fetches (link, response) VALUES (?,?)', link.to_s, deltatime.to_s)
    end

    def self.log_balance(time, balance)
        @db.execute('INSERT INTO wallet (time, balance) VALUES (?,?)', time, balance)
    end

    def self.add_arbitrage_odds_db(match, arbitrage_odds)
        match = match.to_s
        sport = match.slice(28,match.length).split('/')[0]
        i=0
        arbitrage_odds.each do 
            team1_odds = "#{arbitrage_odds[i][0][0].to_s}"
            team2_odds = "#{arbitrage_odds[i][1][0].to_s}"
            team1_bet = "#{arbitrage_odds[i][0][1].to_s}"
            team2_bet = "#{arbitrage_odds[i][1][1].to_s}" 
            market_margin = "#{arbitrage_odds[i][2]}%"
            i += 1
            @db.execute('INSERT INTO odds (match, team1_odds, team2_odds, team1_bet, team2_bet, market_margin, sport) VALUES (?,?,?,?,?,?,?)', match, team1_odds, team2_odds, team1_bet, team2_bet, market_margin, sport)
        end
        
    end

    def self.db_setup()

        db_temp = SQLite3::Database.new('db/data.db')

        db_temp.execute('DROP TABLE IF EXISTS fetches;')

        db_temp.execute('DROP TABLE IF EXISTS odds;')

        db_temp.execute('DROP TABLE IF EXISTS wallet;')

        db_temp.execute('CREATE TABLE "fetches" (
            "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            "link"	TEXT NOT NULL,
            "response" TEXT NOT NULL
        );')

        db_temp.execute('CREATE TABLE "odds" (
            "match"	TEXT NOT NULL,
            "team1_odds" TEXT NOT NULL,
            "team2_odds" TEXT NOT NULL,
            "team1_bet" INT NOT NULL,
            "team2_bet" INT NOT NULL,
            "market_margin" TEXT NOT NULL,
            "sport" TEXT NOT NULL
        );')

        db_temp.execute('CREATE TABLE "wallet" ("time" TEXT NOT NULL, "balance" INT NOT NULL);')
    
    end


end