require 'rubygems'
require 'nokogiri'
require 'byebug'
require 'mechanize'

# Dir.glob("*.rb") { |f| require_relative f}





page = Mechanize.new.get('https://oddschecker.com/')


page.links_with(class: "nav-link beta-footnote").each do |link|
    puts link
    
end



