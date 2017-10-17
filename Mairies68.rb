#!/usr/bin/env ruby
#Zack
require 'google_drive'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def recup_email(url) 

	

	page = Nokogiri::HTML(open(url))
	links = page.css("a.lientxt")

	#Define array that woill be returned (array of hash)
	array_email =[]
	links.each do|lien_ville|
		#a = "http://annuaire-des-mairies.com" + departement['href'].slice!(1..33)
		ville = lien_ville.text
		#puts ville
		link_to_email = "http://annuaire-des-mairies.com" + lien_ville['href']#.slice!(1..33)
		 mailv = Nokogiri::HTML(open(link_to_email))
		
			mailv.css('p:contains("@")').each do |node|
				email = node.text
				#puts email and town
				#set_worksheet(row_number, 1, ville)
				#set_worksheet(row_number, 2, email)
				array_email << {:ville => ville, :email => email[1..-1]}
			end			
	end
	array_email
end



def update_worksheet(array)
	session = GoogleDrive::Session.from_config("config.json")
	worksheet = session.spreadsheet_by_key("1PzbUao-3UscYOWh48FL061r5yYcH2TBl1oWXtmaW1cw").worksheets[0]

	row_number = 1
	array.each do |l|
		worksheet[row_number,1] = l[:ville]
		worksheet[row_number,2] = l[:email]
		row_number+=1
		worksheet.save
	end

end


def do_all

	array1 = recup_email("https://www.annuaire-des-mairies.com/haut-rhin.html")
	array2 = recup_email("https://www.annuaire-des-mairies.com/haut-rhin-2.html")
	array_final = array1 + array2
	update_worksheet(array_final)
end
do_all

#def set_worksheet(row_number, column_number, value_to_update)
   ## $worksheet.save
#end




#update_worksheet(array_final)


#see_more = browser.text_field(href: 'haut-rhin.html')

#see_more.click

#browser.driver.manage.timeouts.implicit_wait = 5

=begin
#def get_the_email_of_a_townhal_from_its_webpage(url)
 #   page = Nokogiri::HTML(open(url))
  #  email = page.xpath('//table/tr[3]/td/table/tr[1]/td[1]/table[4]/tr[2]/td/table/tr[4]/td[2]/p/font')
    #puts email.text
   # email.text
#end

#def get_all_the_urls_of_val_doise_townhalls(url)
 #   towns_mail_list = Hash.new()
  #  page = Nokogiri::HTML(open(url))
   # page.xpath('//table/tr[2]/td/table/tr/td/p/a').each do |town|
    #    town_name = town.text.downcase
     #   proper_town_name = town_name.capitalize
      #  town_name = town_name.split(' ').join('-')
       # url = "http://annuaire-des-mairies.com/95/#{town_name}.html"
        #towns_mail_list[proper_town_name.to_sym] = get_the_email_of_a_townhal_from_its_webpage(url)
    #end
    counter = 2
    towns_mail_list.each do |key, value|
        $worksheet[counter, 1] = key
        $worksheet[counter, 2] = value
        counter += 1
        $worksheet.save
    end

end
get_all_the_urls_of_val_doise_townhalls(VAL_DOISE_URL)
=end