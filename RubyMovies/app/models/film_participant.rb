class FilmParticipant < ActiveRecord::Base
	belongs_to :film
	belongs_to :participant
end
