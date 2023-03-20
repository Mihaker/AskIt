class AnswersController < ApplicationController
before_action :set_question!

 
    def edit 
        @answer = @question.answers.find params[:id]
    end    

    def update
        @answer = @question.answers.find params[:id] 
            if @answer.update answer_params
              flash[:sucess] = 'Question updated'
              redirect_to  question_path(@question)
            else
              render :edit
            end

    end

    def create
        @answer = @question.answers.build answer_params
        
        if @answer.save
          flash[:sucess] = 'Answers add!'
          redirect_to question_path(@question)
        else
           @answers = @question.answers.order  created_at: :desc
          render 'question/show'    
        end

   end

   def destroy
     @answer = @question.answers.find params[:id]
     @answer.destroy
     flash[:sucess] = 'Answer Deleted!'
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