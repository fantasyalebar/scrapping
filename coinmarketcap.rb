#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'uri'
#-----------------------------------------------------------------------------------
def get_all_crypto_names(page)
	crypto_names = []
	idx = 0
	page.xpath('//a[@class="currency-name-container link-secondary"]').each do |name|
		crypto_names[idx] = name.content
		idx += 1
	end 
	return crypto_names
end 
#-----------------------------------------------------------------------------------
def get_all_crypto_price(page)
	crypto_price = []
	idx = 0
	page.xpath('//a[@class="price"]').each do |value|
		crypto_price[idx] = name.value
		idx += 1
	end 
	return crypto_price
end 
#-----------------------------------------------------------------------------------
def hashage(page)
	key = []
	values = []
	idx = 0
	key = get_all_crypto_names(page)
	values = get_all_crypto_price(page)

    crypto_hash = key.zip(values)
    Hash[crypto_hash]

    return crypto_hash
end
#-----------------------------------------------------------------------------------
def every_hour(page)
	t = Time.now
	before_time = t.strftime "%H:%M:%S %z"
	loop do
		the_time = t.strftime "%H:%M:%S %z"

		if the_time.to_i == before_time.to_i + 1
			puts hashage(page)
			before_time = the_time
		else
			puts "il est #{the_time} Actualisation tout les 1h!"
		end
	end
end 
#-----------------------------------------------------------------------------------
market = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all'))

#puts get_all_crypto_names(market)
#puts get_all_crypto_price(market)
puts hashage(market)
#puts every_hour(market)
