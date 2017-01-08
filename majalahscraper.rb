#Phone number Scraper for Majalah dot com using watir

require 'watir'
require 'pry'
require 'csv'

main_link = "http://majalah.com"
feed_links = []
phone_number = []

browser = Watir::Browser.new :chrome

#page.1

browser.goto 'http://www.majalah.com/?allclassifieds'

browser.div(:id => "contentLeft").div(:class => "vertiPad").bs.each_with_index do |i,index|
	if index < 50
		feed_links << i.link.href
	end
	print "."
end

feed_links.each do |link|
	puts ". "
	browser.goto link
	phone_number << browser.text.scan(/(?=(01|\+60))(((?:[0-9]( |-)?){7,10}[0-9]|\d{7,10}))/m).flatten - [nil] - ["-"] - ["01"] - ["0"] - [" "]
end


print phone_number.flatten.sort.uniq!
#Pry.start(binding)

