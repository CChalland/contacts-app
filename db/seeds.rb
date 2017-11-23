# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

contact = Contact.new(first_name: "Evan", last_name: "Nigthingale", email: "evannightingale@gmail.com", phone_number: "(248)-234-5678")
contact.save

Contact.create(first_name: "Kyle", last_name: "Nightingale", email: "kylenightingale@gmail.com", phone_number: "(248)-123-4567")

Contact.create(first_name: "Dean", last_name: "Nightingale", email: "deannightingale@gmail.com", phone_number: "(248)-987-6543")