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
	validates :link, :format => URI::regexp(%w(http https)), :allow_blank => true

	#http://stackoverflow.com/questions/8481132/rails-3-make-text-field-accept-only-numeric-values
	validates :year, :numericality => {:only_integer => true}, :allow_blank => true

	validates :title, :presence => true

	#make films taggable
	acts_as_taggable

	def self.findbytags(tags)
		where(active: true).tagged_with(tags, :any => true)
	end

	def review note, user
		r = Review.new
		r.note = note
    	r.film = self
    	r.user = user
    	r.save
	end

	def set_active
		self.active = true
    	self.save
	end
end
