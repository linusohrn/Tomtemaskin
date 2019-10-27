require 'rubygems'
require 'nokogiri'
require 'byebug'
require 'mechanize'

Dir.glob("*.rb") { |f| require_relative f}



class Findus < Mechanize
    
    def val_good_links(page)
        
        page.links_with(class: "link-item beta-footnote").each do |link|
            puts link
            
        end
        
    end
    
end

