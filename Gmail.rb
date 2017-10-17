require "google_drive"
require 'pry'
require 'json'
require 'csv'
require 'gmail'


def Operation_on_gmail(mails)
gmail = Gmail.connect("angel.castellano.k@gmail.com", "angelcastellano")          
	puts gmail.logged_in?

# envoi de mail
           # email = gmail.compose do
           #   to "sybknt@gmail.com"
           #   subject "Having fun in Puerto Rico!"
           #   body "Spent the day on the road..."
           # end
           # email.deliver!  # or: gmail.deliver(email)

    #puts mails
    mails.each do |mail|
   # puts mail
mail = mail[1..-1]
gmail.deliver do
  to mail
 subject "Formation gratuite au code !"

  
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "<p>Bonjour, je m'appelle Zakaria, je suis élève à une formation de code gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau. La formation s'appelle The Hacking Project (http://thehackingproject.org/). Nous apprenons l'informatique via la méthode du peer-learning : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes. Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite.

Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule dans votre ville, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes, ou confirmées. Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves), donc nous serions ravis de travailler avec {townhall_name} !

Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80</p>"
  
end


 



             # puts "do you wou to delete this msg (enter : 'oui' to valid)"
             # a = gets
             # a.to_s
             # puts a.chomp
             # if a == "oui"
             #     puts gmail.inbox.find(:from => "sybknt@gmail.com").count
             #     gmail.inbox.find(:from => "sybknt@gmail.com").each do |email|
             #           email.delete!
             #     end
             # end
       end
       p "email envoyé à #{mail}"
end
end

#sauvegarde dans google drive
def save_from_on_GoogleDrive
   session = GoogleDrive::Session.from_config("config.json")
#   ws = session.spreadsheet_by_key("1PzbUao-3UscYOWh48FL061r5yYcH2TBl1oWXtmaW1cw").worksheets[0]   #cle a changer en fonction du lien url du fichier google drive
   ws = session.spreadsheet_by_key("1PzbUao-3UscYOWh48FL061r5yYcH2TBl1oWXtmaW1cw").worksheets[1]   #cle a changer en fonction du lien url du fichier google drive
   table_of_mails=[]
   #  for i in 1..table_data.length
   #    ws[i, 1] = table_data[i-1][:nom]
   #    ws[i, 2] = table_data[i-1][:url]
   #    ws[i, 3] = table_data[i-1][:email]
   #  end
    puts ws.num_rows
    (1..(ws.num_rows + 1)).each do |row|
       puts ws[row + 1, 2]
       table_of_mails << ws[row + 1, 2]
    end
    Operation_on_gmail(table_of_mails)
    ws.save
    ws.reload
end




#éxécution du code principal
def perform
   #  array_of_cities_data = get_all_the_urls_of_val_doise_townhalls()
   #  puts array_of_cities_data
    save_from_on_GoogleDrive
   #  save_data_in_json_file(array_of_cities_data)
   #  save_data_in_CSV_file(array_of_cities_data)
end

# appelle de la procédure
perform

# puts gmail.inbox.count
# puts gmail.inbox.count(:unread)
# puts gmail.inbox.count(:read)
# puts gmail.inbox.count(:unread, :from => "myboss@gmail.com")
# puts gmail.mailbox('Urgent').count  if gmail.labels.exists?("Urgent")
# puts gmail.inbox.emails(gm: '"testing"')
# puts gmail.inbox.find("")
# puts gmail.inbox.search("...")
# puts gmail.inbox.mails("")
# puts gmail.inbox.find(
#   :after => Time.parse('2016-01-01 07:50:21'),
#   :before => Time.parse('2016-04-05 21:55:05')
 # )

#Delete emails from X:
# gmail.inbox.find(:from => "x-fiance@gmail.com").each do |email|
#   email.delete!
# end