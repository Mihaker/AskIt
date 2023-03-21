class QuestionsController < ApplicationController
    before_action :set_question! , only: %i[show destroy edit update]
   
    def destroy
      @question.destroy
      flash[:sucess] = 'Question deleted'
      redirect_to  questions_path
    end 

    def create
        @question = Question.new question_params
      if @question.save
        flash[:sucess] = 'Question created'
        redirect_to  questions_path

      else
        render :new
      end

    end

    def show 
      @answer = @question.answers.build
      @answers = @question.answers.order(created_at: :desc).page params[:page]
    end 

    def edit
    end
 
    def update
      
      if @question.update question_params
        flash[:sucess] = 'Question updated'
        redirect_to  questions_path
      else
        render :edit
      end

    end

    def index
      @questions = Question.order(created_at: :desc).page params[:page]
    end

    def new 
     @question = Question.new
    end 
 
  private

    def set_question!
        @question = Question.find params[:id]
    end
    
    def question_params
      params.require(:question).permit(:title, :body)
    end

end
