require 'rubygems'
require 'nokogiri'
require 'mechanize'
require 'byebug'


agent = Mechanize.new

page = agent.get('http://oddschecker.com/')

sports = {}

sports_good =["Tennis", "Ice Hockey", "Table Tennis", "Basketball", "American Football", "Badminton", "Baseball"]

# p link_links
good_links = {}

sports_good.each do |sport|
    good_links[sport] = page.link_with(:text => sport)
end

# good_links.each do |link|
#     link.
# end

