class ProjectsController < ApplicationController
  impressionist :actions=>[:show]
  skip_before_action :authenticate_user!, only: [ :show ]

  def show
    @user = current_user
    @question = Question.new
    @contribution = Contribution.new
    @similar_projects = Project.all[0..2]
    @project = Project.find(params[:id])
    @questions = Question.where(project_id: @project.id)
    authorize @project
    impressionist(@project)
    # This simply calls the similarly named method in the application_policy file (called Show?)
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project
    @project.user = current_user
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    redirect_to company_project_path(@project)
    authorize @project
  end

  def destroy
    @project = Project.find(params[:id])
    authorize @project
    @project.destroy
    redirect_to company_dashboard_index_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :brief, :category, :end_date, :max_participations)
  end

end
