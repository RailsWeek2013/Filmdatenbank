class Participant < ActiveRecord::Base
	has_many :film_participants
	has_many :films, through: :film_participants
end
