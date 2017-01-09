#Phone number Scraper for Majalah dot com using watir

require 'watir'
#require 'pry'
require 'csv'

########################
pages_to_iterate = 50
########################

main_link = "http://majalah.com"


page = 1

browser = Watir::Browser.new :chrome



pages_to_iterate.times.each do |i|
	phone_number = []
	feed_links = []
	browser.goto 'http://www.majalah.com/?allclassifieds.page.' + page.to_s
	
	puts "start page " + page.to_s

	puts "\nstoring links from page"

	browser.div(:id => "contentLeft").div(:class => "vertiPad").bs.each_with_index do |i,index|
		if index < 50
			feed_links << i.link.href
		end
		print "."
	end


	puts "\nscanning phone numbers"

	feed_links.each_with_index do |link,index|
		print "."
		browser.goto link
		phone_number << browser.text.scan(/(?=(01|\+60))(((?:[0-9]( |-)?){7,10}[0-9]|\d{7,10}))/m).flatten - [nil] - ["-"] - ["01"] - ["0"] - [" "]
		sleep(5)
	end

	phone_number.flatten!.sort!

	phone_number.each do |i|
		i.delete!(' ')
		i.delete!('-')
	end

	phone_number.uniq!

	CSV.open("phonenumber.csv", "a") { |csv| csv.puts phone_number}
	puts "finish page " + page.to_s
	page = page + 1
end


#Pry.start(binding)

