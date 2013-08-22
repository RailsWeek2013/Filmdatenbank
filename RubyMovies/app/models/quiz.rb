class Quiz < ActiveRecord::Base

	belongs_to :q1, :class_name => 'Question'
	belongs_to :q2, :class_name => 'Question'
	belongs_to :q3, :class_name => 'Question'
	belongs_to :q4, :class_name => 'Question'
	belongs_to :q5, :class_name => 'Question'

	def self.quiz
		quiz = Quiz.new
		questions = Question.get_n_questions(5)
		quiz.q1 = questions[0] 
		quiz.q2 = questions[1]
		quiz.q3 = questions[2]
		quiz.q4 = questions[3]
		quiz.q5 = questions[4]
		quiz
	end
end
