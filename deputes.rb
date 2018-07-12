#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'uri'
#-----------------------------------------------------------------------------------
def get_all_users_names(page)
	user_names = []
	idx = 0
	page.xpath('//h2[@class="titre_normal"]').each do |name|
		user_names[idx] = name.content
		idx += 1
	end 
	return user_names
end 
#-----------------------------------------------------------------------------------
def get_user_email(page)
	user_contact = []
	user_mail = []
	idx = 0

	#cette premiere boucle me recup les num et email
	page.xpath('//ul[@class="no_puce list_ann"]//li//a[@class="ann_mail"]').each do |item|
		user_contact[idx] = item.content
		idx += 1
	end 

	#je reparcours mon tableau de contacte pour ne garder que les email

	user_contact.each do |item|

		unless item[1].match(/\+/)
		 	user_mail[idx] = item
		 	idx += 1
		end 
	end 
	return user_mail
end 
#-----------------------------------------------------------------------------------
def hashage(key,values)
    dep_hash = key.zip(values)
    Hash[dep_hash]

    return dep_hash
end
#-----------------------------------------------------------------------------------
def global_method
	page1 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr#pagination_deputes'))
	page2 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=50#pagination_deputes'))
	page3 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=100#pagination_deputes'))
	page4 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=150#pagination_deputes'))
	page5 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=200#pagination_deputes'))
	page6 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=250#pagination_deputes'))
	page7 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=300#pagination_deputes'))
	page8 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=350#pagination_deputes'))
	page9 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=400#pagination_deputes'))
	page10 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=450#pagination_deputes'))
	page11 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=500#pagination_deputes'))
	page12 = Nokogiri::HTML(open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=50&lang=fr&debut_deputes=550#pagination_deputes'))
   
	a = get_all_users_names(page1) + get_all_users_names(page2) + get_all_users_names(page3) + get_all_users_names(page4) + get_all_users_names(page5)
	b = get_all_users_names(page6) + get_all_users_names(page7) + get_all_users_names(page8) + get_all_users_names(page9) + get_all_users_names(page10)
	c = get_all_users_names(page11) + get_all_users_names(page12)

	e = get_user_email(page1) + get_user_email(page2) + get_user_email(page3) + get_user_email(page4) + get_user_email(page5)
    f = get_user_email(page6) + get_user_email(page7) + get_user_email(page8) + get_user_email(page9) + get_user_email(page10)
    g = get_user_email(page11) + get_user_email(page12)	

    all_users_names = a + b + c
    all_users_mail = e + f + g

    hash_dep = hashage(all_users_names, all_users_mail)

    return hash_dep
end 

#-----------------------------------------------------------------------------------


#puts get_all_users_names(page1)
#puts get_user_email(page1)
puts global_method
