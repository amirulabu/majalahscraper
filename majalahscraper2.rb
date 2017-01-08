#Phone number Scraper for Majalah dot com

require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'
require 'csv'

main_link = "http://majalah.com"
feed_links = []

page = HTTParty.get('http://www.majalah.com/?allclassifieds')

parse_page = Nokogiri::HTML(page)

parse_page.css('div.horiPad').xpath("b//a").each do |link|
	x = main_link + link['href'][1..-1]
	feed_links << x
	ads_page = HTTParty.get(x.to_s) #somehow, no content retrieved, maybe the site is secured against crawlers?
	#Pry.start(binding)
end

p feed_links

#Pry.start(binding)