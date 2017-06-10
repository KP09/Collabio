class QuestionsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @user = current_user
    @question = Question.new(question_params)
    @question.project_id = @project.id
    @question.user_id = @user.id
    authorize @question
    if @question.save
      redirect_to project_path(@project)
    else
      @similar_projects = Project.all.sample(3)
      render 'projects/show'
    end
  end

  def edit
    @question = Question.find(params[:id])
    authorize @question
  end

  def update
    @question = Question.find(params[:id])
    @project = @question.project
    authorize @question
    if @question.update(question_params)
      redirect_back(fallback_location: root_path)
    else
      render 'projects/show'
      # need to make sure the edit view of contributions is called 'edit!'
    end
  end

  def destroy
  end

private

  def question_params
    params.require(:question).permit(:question, :answer)
  end

end
