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
User.create!(name: "admin", email: "admin@rm.de", password: "admin123", role:r )
User.create!(name: "benutzuer", email: "benutzer@rm.de", password: "benutzer123", role:r2 )