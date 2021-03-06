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
    current_tot_q = cookies[:tot_q].to_f
    if current_tot_q.nil?
      cookies[:tot_q] = 4
    end

    current_q = cookies[:no_q].to_f
    if current_q.nil?
      cookies[:no_q] = 0
    end

    current_q = cookies[:no_q].to_f
    current_q += 1
    cookies[:no_q] = current_q

    current_correct = cookies[:correct].to_f
    if current_correct.nil?
      cookies[:correct] = 0
    end

    answer = params[:ans] + "_correct"
    question = params[:question]
    
    @question = Question.find(question)

    @question.correct_answers.each do |bool|
      if bool[1] == "true" && bool[0] == answer
        current_correct = cookies[:correct].to_f
        current_correct += 1
        cookies[:correct] = current_correct
      end
    end

    if cookies[:no_q] > cookies[:tot_q].to_f
      redirect_to results_path
    else
      redirect_to root_path
    end
  end

  def result
    @no_correct = cookies[:correct].to_f
  end

  def reload
    cookies[:correct] = 0
    cookies[:no_q] = 0
    cookies[:tot_q] = 4

    redirect_to root_path
  end  

  def set_no_questions
    cookies[:tot_q] = params[:tot_questions]
  end
end
