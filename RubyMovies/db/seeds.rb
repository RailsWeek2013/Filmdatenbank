# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create roles
role_admin = Role.create(name: "Admin")
role_mod = Role.create(name: "Moderator")
role_user = Role.create(name: "User")
role_guest = Role.create(name: "Gast")

#Create default Admin, Mod, User
admin = User.create!(name: "Admin", email: "admin@rm.de", password: "admin123", role: role_admin )
moderator = User.create!(name: "Moderator", email: "moderator@rm.de", password: "moderator123", role: role_mod)
user = User.create!(name: "Benutzer", email: "benutzer@rm.de", password: "benutzer123", role: role_user )

#Create some films
spiderman = Film.create!(title: "The Amazing Spiderman", link: "http://www.youtube.com/watch?v=-tnxzJ0SSOw", average: "3.0", director: "Marc Webb", actor: "Andrew Garfield, Emma Stone", producer: "Avi Arad", year: "2012", description: "Der neue Spiderman", tag_list: "spiderman, comic, action, marvel", active: true)
Comment.create!(text: "Dies ist ein toller Film!", film: spiderman , user: user)
Comment.create!(text: "Dies ist auch ein toller Kommentar!", film: spiderman , user: moderator)

batman = Film.create!(title: "Batman Begins", link: "http://de.wikipedia.org/wiki/Batman_Begins", average: "5.0", year: "2005", tag_list: "action, comic, dc", active: true)
Comment.create!(text: "Dies ist ein toller Film!", film: batman , user: moderator)
Comment.create!(text: "Dies ist auch ein toller Kommentar!", film: batman , user: admin)

i = 0
3.times do
	Film.create!(title: "Testtitel#{i}", description: "Dies ist ein Testfilm", tag_list: "action", active: true )
	i += 1
end

3.times do
	Film.create!(title: "Testtitel#{i}", description: "Dies ist ein Testfilm", tag_list: "comedy, action", active: false )
	i += 1
end

review_batman = Review.create!(user: user, film: batman, note: 5)
review_spiderman = Review.create!(user: user, film: spiderman, note: 3)

Message.create!(sender: admin, recipient: user, subject: "Testnachricht", text: "Testtext der Nachricht")
Message.create!(sender: moderator, recipient: admin, subject: "Testnachricht2", text: "Testtext der Nachricht2")
Message.create!(sender: user, recipient: moderator, subject: "Testnachricht3", text: "Testtext der Nachricht3")

Question.create!(title: "Welche Figur spielt Johnny Depp in Fluch der Karibik?", answer1: "Spiderman", answer2: "Captain Barbossa", answer3: "Captain Jack Sparrow", answer4: "James Bond", solution: "3", active: true)
Question.create!(title: "Wer ist Spidermans Gegner in The Amazing Spiderman?", answer1: "Spiderman", answer2: "Green Goblin", answer3: "Gwen Stacy", answer4: "Lizard", active: true, solution: "4")
Question.create!(title: "Wie viele Mission Impossible Teile gibt es?", answer1: "1", answer2: "2", answer3: "3", answer4: "4", active: false, solution: "4")
