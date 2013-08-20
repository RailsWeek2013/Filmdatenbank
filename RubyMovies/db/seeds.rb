# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create roles
r = Role.create(name: "Admin")
Role.create(name: "Moderator")
r2 = Role.create(name: "User")
Role.create(name: "Gast")
#Create default Admin
a = User.create!(name: "admin", email: "admin@rm.de", password: "admin123", role:r )
b = User.create!(name: "benutzer", email: "benutzer@rm.de", password: "benutzer123", role:r2 )
f = Film.create!(title: "Test", description: "Beschreibung", active: true)
Comment.create!(text: "Dies ist ein toller Kommentar!", film: f , user: b)
Comment.create!(text: "Dies ist auch ein toller Kommentar!", film: f , user: a)
Message.create!(sender: a, recipient: b, subject: "Testnachricht", text: "Testtext der Nachricht")
Message.create!(sender: b, recipient: a, subject: "Testnachricht2", text: "Testtext der Nachricht2")