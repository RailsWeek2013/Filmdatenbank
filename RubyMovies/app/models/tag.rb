class Tag < ActiveRecord::Base
	has_many :film_tags
	has_many :films, through: :film_tags
end
