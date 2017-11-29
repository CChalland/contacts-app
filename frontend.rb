require "unirest"
require "pp"

params = {}

while true
  system "clear"
  puts "Welcome to your contact list! Select an option:"
  puts "[1] See all the contacts"
  puts "    [1.1] Search contacts by First name"
  puts "    [1.2] Search contacts by Middle name"
  puts "    [1.3] Search contacts by Last name"
  puts "    [1.4] Search contacts by Phone number"
  puts "    [1.5] Search contacts by Email"
  puts "[2] Create a new contact"
  puts "[3] Show a particular contact"
  puts "[4] Update the particular contact"
  puts "[5] Delete the particular contact"
  puts
  puts "[signup] Signup (create a user)"
  puts "[login] Login (create a JSON web token)"
  puts "[logout] Logout (erase the JSON web token)"
  puts
  puts "[q] Quit"

  input_answer = gets.chomp

  if input_answer == "1"
    response = Unirest.get("http://localhost:3000/contacts")
    contacts = response.body
    pp contacts

  elsif input_answer == "1.1"
    print "Enter the First name to search by: "
    search_input = gets.chomp
    # response = Unirest.get("http://localhost:3000/contacts", parameters: {search_first_name: search_input})
    response = Unirest.get("http://localhost:3000/contacts?search_first_name=#{search_input}")

    contacts = response.body
    pp contacts

  elsif input_answer == "1.2"
    print "Enter the Middle name to search by: "
    search_input = gets.chomp
    response = Unirest.get("http://localhost:3000/contacts", parameters: {search_middle_name: search_input})
    contacts = response.body
    pp contacts

  elsif input_answer == "1.3"
    print "Enter the Last name to search by: "
    search_input = gets.chomp
    response = Unirest.get("http://localhost:3000/contacts", parameters: {search_last_name: search_input})
    contacts = response.body
    pp contacts

  elsif input_answer == "1.4"
    print "Enter the Phone number to search by: "
    search_input = gets.chomp
    response = Unirest.get("http://localhost:3000/contacts", parameters: {search_phone_number: search_input})
    contacts = response.body
    pp contacts

  elsif input_answer == "1.5"
    print "Enter the Email to search by: "
    search_input = gets.chomp
    response = Unirest.get("http://localhost:3000/contacts", parameters: {search_email: search_input})
    contacts = response.body
    pp contacts

  elsif input_answer == "2"
    user_response = Unirest.get("http://localhost:3000/users/#{params[:id]}")
    puts "Enter the following infomation for the contact"
    params[:user_id] = user_response.id
    puts "Enter the contact's first name:"
    params[:first_name] = gets.chomp
    print "Enter the contact's middle name: "
    params[:middle_name] = gets.chomp
    puts "Enter the contact's last name:"
    params[:last_name] = gets.chomp
    puts "Enter the contact's email:"
    params[:email] = gets.chomp
    puts "Enter the contact's phone number:"
    params[:phone_number] = gets.chomp
    print "Enter the contact's bio: "
    params[:bio] = gets.chomp
    response = Unirest.post("http://localhost:3000/contacts/", parameters: params)
    contact = response.body
    pp contact
    
  elsif input_answer == "3"
    puts "Enter the contact ID#:"
    input_id = gets.chomp
    response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
    contact = response.body
    pp contact

  elsif input_answer == "4"
    puts "Enter the contact ID#:"
    input_id = gets.chomp
    
    puts "Change the following infomation"
    print "Enter the new contact's first name: "
    params[:first_name] = gets.chomp
    print "Enter the new contact's middle name: "
    params[:middle_name] = gets.chomp
    print "Enter the new contact's last name: "
    params[:last_name] = gets.chomp
    print "Enter the new contact's email: "
    params[:email] = gets.chomp
    print "Enter the new contact's phone number: "
    params[:phone_number] = gets.chomp
    print "Enter the new contact's bio: "
    params[:bio] = gets.chomp
    response = Unirest.patch("http://localhost:3000/contacts/#{input_id}", parameters: params)
    contact = response.body
    pp contact

  elsif input_answer == "5"
    puts "Enter the contact ID#:"
    input_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/contacts/#{input_id}")
    pp response.body

  elsif input_answer == "signup"
    
    print "Name: "
    params[:name] = gets.chomp
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    print "Password confirmation: "
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("http://localhost:3000/users", parameters: params)
    pp response.body
  elsif input_answer == "q"
    puts "Goodbye!"
    break

  elsif input_answer == "login"
    puts "Login to the app"
    
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    response = Unirest.post(
      "http://localhost:3000/user_token",
      parameters: {auth: {email: params[:email], password: params[:password]}}
    )
    pp response.body
    # Save the JSON web token from the response
    jwt = response.body["jwt"]
    # Include the jwt in the headers of any future web requests
    Unirest.default_header("Authorization", "Bearer #{jwt}")

  elsif input_answer == "logout"
    jwt = ""
    Unirest.clear_default_headers()
 
  elsif input_answer == "q"
    puts "Goodbye!"
    break
  end

  puts 
  puts "Press enter to continue"
  gets.chomp
end

