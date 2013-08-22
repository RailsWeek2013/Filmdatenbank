module QuestionsHelper
	def checked? id
		if params[:answer] == id
			true
		else
			false
		end
	end

	def active question
		if question.active
			"Ja"
		else
			"Nein"
		end
	end
end
