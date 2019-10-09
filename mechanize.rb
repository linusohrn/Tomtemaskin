require 'rubygems'
# require 'nokogiri'
require 'byebug'
require 'mechanize'

# Dir.glob("*.rb") { |f| require_relative f}


class Findus < Mechanize
    
    def get_link(list)
        list_links = []
        list.each do |temp_link|
            list_links << get(temp_link.uri)
            sleep(0.01)
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
                        
                    end
                else
                    sports << link
                end
            end
        end
        
        sport_page = get_link(sports)
        
        
        return sport_page
    end
    
    
    def get_matches(sport_pages)
        matches = []
        good_matches = []
        sport_pages.each do |sport|
            # byebug
            # puts sport.uri
            if sport.links_with(class: "beta-callout full-height-link whole-row-link").empty? == false
                if sport.search('td.bet-headers').at('td:contains("Draw")')
                    # puts sport.search('td.bet-headers').at('td:contains("Draw")')
                    # puts sport.search("//td[@class='bet-headers beta-callout']")
                else
                    
                    # puts sport.uri
                    # puts sport.links_with(class: "beta-callout full-height-link whole-row-link")
                    sport.links_with(class: "beta-callout full-height-link whole-row-link").each do |temp|
                        good_matches << temp
                    end
                end
                
                
            end
            
            matches = get_link(good_matches)
            
            return matches
        end
    end
    
    def get_odds(matches)
        
        matches.each do |match|
            
            puts match.attr("data-best-dig")
            
        end
        
    end
    
    def init(page)
        
        agent = self.get(page)
        sports = get_good_links(agent)
        matches = get_matches(sports)
        get_odds(matches)
        
    end
    
    
end



Findus.new.init('https://oddschecker.com/')


