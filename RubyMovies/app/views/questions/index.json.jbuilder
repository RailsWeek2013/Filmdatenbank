json.array!(@questions) do |question|
  json.extract! question, :title, :answer1, :answer2, :answer3, :answer4, :solution, :active
  json.url question_url(question, format: :json)
end
