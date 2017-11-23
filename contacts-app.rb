require 'unirest'

all_contacts_url = Unirest.get("http://localhost:3000/all_contacts")
all_contacts = all_contacts_url.body

system "clear"
puts "Welcome to your Contacts"
puts
i = 1
all_contacts.each do |contact|
  puts "#{i}. #{contact["first_name"]} #{contact["last_name"]}"
  i += 1
end

while true
  puts "Enter the contact number to view full infomation."
  answr = gets.chomp
  if answr == 'Q'
    break
  end
  answer = answr.to_i - 1
  puts "#{answr}. #{all_contacts[answer]["first_name"]} #{all_contacts[answer]["last_name"]}"
  puts "    Phone Number: #{all_contacts[answer]["phone_number"]}"
  puts "    Email: #{all_contacts[answer]["email"]}"
  puts
  puts "Enter 'Q' to quit the program"
end