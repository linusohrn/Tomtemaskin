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
        # pp match.uri
        
        odds_arr = []
        # puts match.uri
        if !match.nil?
            # pp match.uri
            if match.search('tr.evTabRow').length == 2
                teams = match.search('tr.evTabRow')
                teams.each do |team|
                    temp_arr = []
                    team.search('td.bc.bs').each do |odd|
                        # pp odd
                        # Remove whitespace
                        odd_children = odd.children.text.gsub(/\s+/, "")
                        
                        if !odd_children.empty?

                            # Make into fraction
                            if !odd_children.include?("/")
                                odd_children+="/1"
                            end
                            # pp odd_children
                            temp_arr << odd_children
                            # pp odd_children
                            
                        end
                    end
                    odds_arr << temp_arr
                end
                
                
            end
            # pp match.uri
            # pp odds_arr.length
            if odds_arr.length < 2
                # pp odds_arr
                odds_arr = odds_arr.first
            end
            # pp odds_arr
            if !odds_arr.nil? && !odds_arr.empty?
                return match.uri, odds_arr
            end 
            
        end  
    end 
    
end


