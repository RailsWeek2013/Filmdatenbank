class Quiz < ActiveRecord::Base

	belongs_to :q1, :class_name => 'Question'
	belongs_to :q2, :class_name => 'Question'
	belongs_to :q3, :class_name => 'Question'
	belongs_to :q4, :class_name => 'Question'
	belongs_to :q5, :class_name => 'Question'

	validates_uniqueness_of :user

	def self.get_quiz user
		quiz = Quiz.where(user: user.id).take
		if quiz.nil?
			quiz = Quiz.new_quiz user
		else
			quiz
		end
	end

	def self.new_quiz user
		quiz = Quiz.where(user: user.id).take
		if quiz.nil?
			quiz = Quiz.new
		end
		questions = Question.get_n_questions(5)
		quiz.q1 = questions[0] 
		quiz.q2 = questions[1]
		quiz.q3 = questions[2]
		quiz.q4 = questions[3]
		quiz.q5 = questions[4]
		quiz.user = user.id
		quiz.save
		quiz
	end

	def to_a
		quiz = Array.new
		quiz.push self.q1 unless self.q1.nil?
		quiz.push self.q2 unless self.q2.nil?
		quiz.push self.q3 unless self.q3.nil?
		quiz.push self.q4 unless self.q4.nil?
		quiz.push self.q5 unless self.q5.nil?
		quiz
	end
end
