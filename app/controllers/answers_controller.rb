class AnswersController < ApplicationController
  def create
    @question = Question.find params[:question_id]
    @answer = Answer.new answer_params
    @answer.question = @question
    if @answer.save
      redirect_to question_path(@question)
    else 
      render "questions/show"
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to question_path(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
