require_relative 'gumman.rb'
#   Web crawler
#   Hämtar alla sidorna med vissa krav
#
class Findus < Mechanize
    
    def initialize
        super
        @gumman = Gumman.new
        @page = self.get('https://oddschecker.com/')
    end
    
    def get_link(list)
        list_links = []
        list.each do |temp_link|
            list_links << get(temp_link.uri)
            add_fetch_db(temp_link.uri)
            sleep(0.03)
        end
        return list_links
        
    end
    
    def add_fetch_db(link)
        @gumman.add_fetch_db(link)
    end
    
    def get_good_links
        sport_page = []
        sports = []
        @page.links_with(class: "nav-link beta-footnote").each do |link|
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
        
        return sports
    end
    
    
    def get_matches(sport)
        matches = []
        sport = get(sport.uri)
        if sport.links_with(class: "beta-callout full-height-link whole-row-link").empty? == false
            if sport.search('td.bet-headers').at('td:contains("Draw")')
                # puts "Draw possible, no bet"
                # pp sport.uri
            else
                
                # puts sport.uri
                # puts sport.links_with(class: "beta-callout full-height-link whole-row-link")
                sport.links_with(class: "beta-callout full-height-link whole-row-link").each do |temp|
                    matches << temp.click
                    # pp temp.click.uri
                end
            end
            
            
            return matches
        end
        
    end
    
end


