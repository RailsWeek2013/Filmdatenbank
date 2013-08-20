class Film < ActiveRecord::Base
	#relations
	has_many :film_participants
	has_many :participants, through: :film_participants
	has_many :reviews
	has_many :users, through: :reviews
	has_many :comments

	#make picture upload work
	mount_uploader :picture, PictureUploader

	#http://stackoverflow.com/questions/5331014/check-if-given-string-is-an-url
	validates :link, :format => URI::regexp(%w(http https))

	#make films taggable
	acts_as_taggable
end
