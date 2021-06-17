json.extract! question, :id, :title, :answers, :multiple_correct, :correct_answers, :tags, :category, :difficulty, :created_at, :updated_at
json.url question_url(question, format: :json)
