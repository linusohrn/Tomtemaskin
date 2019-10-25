require 'rubygems'
# require 'nokogiri'
require 'byebug'
require 'mechanize'
require 'pp'
# Dir.glob("*.rb") { |f| require_relative f}


class Findus < Mechanize
    
    def get_link(list)
        list_links = []
        list.each do |temp_link|
            list_links << get(temp_link.uri)
            @fetches += 1
            sleep(0.001)
        end
        return list_links
        
    end
    
    def get_good_links(page)
        
        sport_page = []
        sports = []
        page.links_with(class: "nav-link beta-footnote").each do |link|
            # sleep(1)
            if link.uri != 'https://www.oddschecker.com/myoddschecker/login'
                
                if link.click.links_with(class: "list-text-indent beta-callout").empty? != true
                    
                    link.click.links_with(class: "list-text-indent beta-callout").each do |lonk|
                        sports << lonk
                        # puts lonk
                        
                    end
                else
                    sports << link
                    # puts link
                end
            end
        end
        
        sport_pages = get_link(sports)
        
        
        return sport_pages
    end
    
    
    def get_matches(sport_pages)
        matches = []
        good_matches = []
        sport_pages.each do |sport|
            # byebug
            # puts sport.uri
            if sport.links_with(class: "beta-callout full-height-link whole-row-link").empty? == false
                if sport.search('td.bet-headers').at('td:contains("Draw")')
                    # puts "Draw possible, no bet"
                    # pp sport.uri
                else
                    
                    # puts sport.uri
                    # puts sport.links_with(class: "beta-callout full-height-link whole-row-link")
                    sport.links_with(class: "beta-callout full-height-link whole-row-link").each do |temp|
                        good_matches << temp.click
                        # pp temp.click.uri
                    end
                end
                
                
            end
            
        end
        matches = get_link(good_matches)
        return matches
    end
    
    def get_odds(matches)
        odds = {}
        
        
        matches.each do |match|
            # pp match.uri
            temp_arr = []
            odds_arr = []
            # pp match.search('td.bc.bs')
            match.search('td.bc.bs').each do |odd|
                # pp odd.children.text
                temp_arr << odd.children.text
            end 
            # pp temp_arr
            long = (temp_arr.length / 2)
            puts long
            temp_arr.each_slice(long) {|a|
            odds_arr << a
            }
            # pp odds_arr
            odds[match.uri] = odds_arr
            
            
        end
        pp odds
        return odds
        
    end
    
    def init(page)
        system("cls") 
        @fetches = 0
        @time = Time.now
        agent = self.get(page)
        sport_pages = get_good_links(agent)
        matches = get_matches(sport_pages)
        odds = get_odds(matches)
        # pp odds
        puts @fetches
        @deltatime = Time.now - @time
        puts "#{@deltatime} seconds"
        
        
    end
    
    
end



Findus.new.init('https://oddschecker.com/')
