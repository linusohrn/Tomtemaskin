require 'rubygems'
# require 'nokogiri'
require 'byebug'
require 'mechanize'

class Findus < Mechanize
    
    def val_good_links(page)
        
        sport_page = []
        sports = []
        page.links_with(class: "nav-link beta-footnote").each do |link|
            # sleep(1)
            if link.uri != 'https://www.oddschecker.com/myoddschecker/login'
                
                if link.click.links_with(class: "list-text-indent beta-callout").empty? != true
                    
                    link.click.links_with(class: "list-text-indent beta-callout").each do |lonk|
                        puts "woo"
                        
                    end
                else
                    puts "moo"
                end
            end
        end
        
        sports.each do |sport|
            sport_page << get(sport) 
        end
        
        
        return sport_page
    end

    
    def init(page)
        
        agent = self.get(page)
        sports = val_good_links(agent)
        
    end
    
    
end



Findus.new.init('https://oddschecker.com/')