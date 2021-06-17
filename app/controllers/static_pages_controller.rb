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

  def incCorrect
    @correct += 1
  end

  def result
  end

  
end
