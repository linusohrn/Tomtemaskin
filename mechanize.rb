require 'rubygems'
require 'nokogiri'
require 'mechanize'
require 'byebug'


agent = Mechanize.new

class Findus
    
    page = agent.get('http://oddschecker.com/')
    
    sports = {}
    
    sports_good =["Tennis", "Ice Hockey", "Table Tennis", "Basketball", "American Football", "Badminton", "Baseball"]
    
    # p link_links
    good_links = []
    
    sports_good.each do |sport|
        good_links << page.link_with(:text => sport)
    end
    
    # puts good_links
    
    docs = {}

    def mech_to_noko(mech)
        return Nokogiri::HTML(open(mech))        
    end

    def noko_to_mech(noko)
        return       
    end
    
    good_links.each do |link|
        
        # puts link
        docs = Nokogiri::HTML(open(link))
    end
    
end


