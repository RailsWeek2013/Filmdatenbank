module ApplicationHelper
	def back
		#http://webjazz.blogspot.de/2007/02/link-back-to-referring-page-in-rails.html
		link_to "Zurück", request.env["HTTP_REFERER"] 
	end
end
