#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'uri'

#-----------------------------------------------------------------------------------
def get_the_email_of_a_townhal_from_its_webpage(page)
	email_vaureal = page.css('td') [7].text
    return email_vaureal
end 
#-----------------------------------------------------------------------------------
def get_all_the_urls_of_val_doise_townhalls(page)
	city_links = []
	idx = 0
	page.xpath('//a[@class="lientxt"]').each do |link|
    	city_links[idx] = "http://annuaire-des-mairies.com#{link['href'].delete_prefix(".")}"
    	idx += 1
    end

    return city_links
end 
#-----------------------------------------------------------------------------------
def get_all_citys_names(page)
	city_names = []
	idx = 0
	page.xpath('//a[@class="lientxt"]').each do |name|
		city_names[idx] = name.content
		idx += 1
	end 
	return city_names
end 
#-----------------------------------------------------------------------------------
def hashage(page)
	key = []
	values = []
	city_links = []
	idx = 0

	key = get_all_citys_names(page)
	city_links = get_all_the_urls_of_val_doise_townhalls(page)

	city_links.each do |link|
		values = get_the_email_of_a_townhal_from_its_webpage(link)
	end 

    city_hash = key.zip(values)
    Hash[city_hash]

    return city_hash
end
#-----------------------------------------------------------------------------------
def global_methode(page1,page2)
	puts get_the_email_of_a_townhal_from_its_webpage(page1)
	puts get_all_the_urls_of_val_doise_townhalls(page2)
	puts get_all_citys_names(page2)
	#puts hashage(page2)
end 
#-----------------------------------------------------------------------------------

vaureal = Nokogiri::HTML(open('http://annuaire-des-mairies.com/95/vaureal.html'))
annuaire = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))

#puts get_the_email_of_a_townhal_from_its_webpage(vaureal)
#puts get_all_the_urls_of_val_doise_townhalls(annuaire)
#puts get_all_citys_names(annuaire)
#puts hashage(annuaire)

global_methode(vaureal,annuaire)