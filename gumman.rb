require 'sqlite3'
#   Databashanterare
#   Lägger till alla fetches och matcher med odds databasen
#   
class Gumman

    def self.connect
        @db = SQLite3::Database.new('db/data.db')
    end

    def self.add_fetch_db(link, deltatime)
        @db.execute('INSERT INTO fetches, time, response (link,) VALUES (?)', link.to_s)
    end


    def self.add_odds_db(match,odds)
        team1 = ""
        team2 = ""
        odds[0].each do |t1o|
            team1 += "#{t1o.to_s}, "
        end
        odds[1].each do |t2o|
            team2 += "#{t2o.to_s}, "
        end
        @db.execute('INSERT INTO odds (match, team1, team2) VALUES (?,?,?)', match.to_s, team1, team2)
    end

    def self.db_setup()

        db_temp = SQLite3::Database.new('db/data.db')

        db_temp.execute('DROP TABLE IF EXISTS fetches;')

        db_temp.execute('DROP TABLE IF EXISTS odds;')

        db_temp.execute('CREATE TABLE "fetches" (
            "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            "link"	TEXT NOT NULL,
            "response" TEXT NOT NULL
        );')

        db_temp.execute('CREATE TABLE "odds" (
            "match"	TEXT NOT NULL,
            "team1"	TEXT NOT NULL,
            "team2"	TEXT NOT NULL
        );')
    
    end


end