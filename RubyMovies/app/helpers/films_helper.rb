module FilmsHelper
	def getyear film
		unless film.year.nil?
			"(#{film.year})"
		else
			""
		end
	end
end
