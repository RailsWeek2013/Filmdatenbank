class Film < ActiveRecord::Base
	has_many :film_participants
	has_many :participants, through: :film_participants
	has_many :reviews
	has_many :users, through: :reviews
	has_many :film_tags
	has_many :tags, through: :film_tags
	has_many :comments

	mount_uploader :picture, PictureUploader
end
