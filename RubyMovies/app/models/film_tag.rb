class FilmTag < ActiveRecord::Base
	belongs_to :film 
	#belongs_to :tag 
end
