class EmployeeyeeMailer < ApplicationMailer
	def welcome_email(user)
		@user = user
		@url = "http://gmail.com"
		mail(to: "hammadbhat66@gmail.com", subject: "Welcome to Welcome haha I joke I joke, I kid I kidd")
	end
end
