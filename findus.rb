require 'rubygems'
require 'nokogiri'
require 'byebug'
require 'mechanize'

Dir.glob("*.rb") { |f| require_relative f}


a = Mechanize.new { |agent|
    agent.user_agent_alias = 'Mac Safari'
}


a.get('https://oddschecker.com/ice-hockey/nhl')
class Findus < Mechanize::Page
    
    
    
    
end

agent = Findus.new

