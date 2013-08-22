class Question < ActiveRecord::Base

	has_many :quiz, :class_name => 'Quiz', :foreign_key => 'q1_id'

	#http://edgeguides.rubyonrails.org/active_record_validations.html
	validates :solution, :numericality => {only_integer: true, less_than: 5, greater_than: 0}, :allow_blank => false

	validates :title, :presence => true

	validates :answer1, :presence => true

	validates :answer2, :presence => true

	validates :answer3, :presence => true

	validates :answer4, :presence => true

	paginates_per 1

	#http://stackoverflow.com/questions/5342270/rails-3-get-random-record
	def self.get_n_questions n 
		Question.where(active: true).order("RANDOM()").limit(n)
	end

end
