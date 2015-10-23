class QuestionsController < ApplicationController
  def index
    @questions = Question.order(id: :desc)
  end

  def edit
  end

  def new
    @question = Question.new
  end

  def create
    new_q = Question.new(valid_params)
    if session[:user_id]
      current_user.questions << new_q
      redirect_to questions_path
    else
      flash[:errors] = "You must be logged in to create questions."
      redirect_to new_question_path
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def update
  end

  def vote
    parent_question = Question.find_by(id: params[:question_id])
    make_vote(parent_question)
  end

  def valid_params
    params.require(:question).permit(:title,:body)
  end

  def tag_params
    params.require(:tag).permit(:description)
  end
end
