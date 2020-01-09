require_relative 'gumman.rb'

#   Web crawler
#   Hämtar alla sidorna med vissa krav
#
class Findus < Mechanize
    
    def initialize
        super
        Gumman.connect()
        @page = self.get('https://oddschecker.com/')
    end
    
    def get_good_links
        sports = []
        @page.links_with(class: "nav-link beta-footnote").each do |link|
            # sleep(1)
            if link.uri != 'https://www.oddschecker.com/myoddschecker/login'
                
                if link.click.links_with(class: "list-text-indent beta-callout").empty? != true
                    
                    link.click.links_with(class: "list-text-indent beta-callout").each do |lonk|
                        sports << lonk.click.uri
                        # puts lonk
                        
                    end
                else
                    # puts link.click.uri
                    sports << link.click.uri
                    # puts link
                end
            end
        end
        # pp sports
        return sports
    end
    
    
    def get_matches(sport)
        matches = []
        time = Time.now
        sport = get(sport)
        deltatime = Time.now - time
        if sport.links_with(class: "beta-callout full-height-link whole-row-link").empty? == false
            if sport.search('td.bet-headers').at('td:contains("Draw")')
                # puts "Draw possible, no bet"
                # pp sport.uri
            else
                
                # puts sport.uri
                # puts sport.links_with(class: "beta-callout full-height-link whole-row-link")
                sport.links_with(class: "beta-callout full-height-link whole-row-link").each do |temp|
                    if !temp.click.nil?
                        matches << temp.click.uri
                        # pp temp.click.uri
                    end
                end
                
                
                # puts sport.uri
                # puts sport.links_with(class: "beta-callout full-height-link whole-row-link")
                sport.links_with(class: "beta-callout full-height-link whole-row-link").each do |temp|
                    if !temp.click.nil?
                        matches << temp.click
                        # pp temp.click.uri
                    end
                end
            end
            
            Gumman.add_fetch_db(sport, deltatime)
            return matches
            
        end
        
    end
    
    def get_odds(match)
        match = get(match)
        temp_arr = []
        odds_arr = []
        # puts match.uri
        if !match.nil?
            if match.search('tr.evTabRow').length == 2
                match.search('tr.evTabRow/td.bc.bs').each do |odd|
                    
                    # Remove whitespace
                    odd_children = odd.children.text.gsub(/\s+/, "")
                    
                    if odd_children.empty? == false
                        
                        # Make into fraction
                        if !odd_children.include?("/")
                            odd_children+="/1"
                        end
                        
                        temp_arr << odd_children
                        
                        
                    end
                end
                
                long = (temp_arr.length / 2)
                if long > 1
                    temp_arr = temp_arr.each_slice(long)
                    temp_arr.each do |temp|
                        
                        if temp.length%2!=0
                            temp.pop(1) 
                            
                            odds_arr << temp
                        else
                            odds_arr << temp
                        end
                    end
                    
                    
                end
                
            end
            pp match.uri
            pp odds_arr
            return match.uri, odds_arr
            
        end  
    end 
    
end


