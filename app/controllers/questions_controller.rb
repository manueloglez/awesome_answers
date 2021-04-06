class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_question, only: [:edit, :update, :show, :destroy]
  def new
    @question = Question.new
  end
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save 
      flash[:primary] = "#{@question.title} created"
      redirect_to question_path(@question.id)
    else
      render :new
    end
  end
  def show
    @answer = Answer.new
    @answers = @question.answers.order(created_at: :desc)
  end
  def index
    @questions = Question.all
  end
  def edit
  end
  def update
    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit
    end
  end
  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private
  def question_params
    params.require(:question).permit(:title, :body)
  end
  def find_question
    @question = Question.find(params[:id])
  end
end