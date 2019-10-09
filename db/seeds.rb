# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
	Role.create(id:1,user_type: 'Admin')
	Role.create(id:2,user_type: 'Employee')
	Role.create(id:3,user_type: 'Client')
	User.create(email: 'eee@gmail.com',password: '123456',role_id: 1)