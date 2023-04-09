# frozen_string_literal: true

class AnswersController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_question!

  def edit
    @answer = @question.answers.find params[:id]
  end

  def create
    @answer = @question.answers.build answer_params

    if @answer.save
      flash[:success] = 'Answers add!'
      redirect_to question_path(@question)
    else
      @question = @question.decorate 
      @pagy, @answers = pagy @question.answers.order created_at: :desc
      @answers = @answers.decorate
      render 'question/show'
    end
  end

  def update
    @answer = @question.answers.find params[:id]
    if @answer.update answer_params
      flash[:sucess] = 'Question updated'
      redirect_to question_path(@question, anchor: dom_id(@answer))
    else
      render :edit
    end
  end

  def destroy
    @answer = @question.answers.find params[:id]
    @answer.destroy
    flash[:success] = 'Answer Deleted!'
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find params[:question_id]
  end

  #    def set_answers!
  #     @answer = @question.answers.find params[:id]
  #    end
end
