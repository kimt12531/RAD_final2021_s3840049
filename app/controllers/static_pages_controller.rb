class StaticPagesController < ApplicationController
  def home
    Question.delete_all

    file = File.read('quiz.json')
    hash = JSON.parse(file)

    hash.each do |h|
      title = h["question"]
      answers = []
      h["answers"].each do |answer|
        answers << answer
      end
      multiple_correct = h["multiple_correct_answers"]
      correct_answers = []
      h["correct_answers"].each do |answer|
        correct_answers << answer
      end
      tags = []
      h["tags"].each do |tag|
        tags << tag
      end
      category = h["category"]
      difficulty = h["difficulty"]
      Question.create!(title: title, answers: answers, multiple_correct: multiple_correct, correct_answers: correct_answers, tags: tags, category: category, difficulty: difficulty)
    end

    @questions = Question.order("RANDOM()")
  end

  def counter
    answer = params[:ans] + "_correct"
    question = params[:question]

    # cookies[:no_q] = cookies[:no_q] + 1
    
    @question = Question.find(question)

    @question.correct_answers.each do |bool|
      if bool[1] == "true" && bool[0] == answer
        current_correct = cookies[:correct].to_f
        current_correct += 1
        cookies[:correct] = current_correct
      end
    end

    redirect_to root_path
  end

  def result
  end

  
end
