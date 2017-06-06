class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    authorize @project
    # This simply calls the similarly named method in the application_policy file (called Show?)
  end

  def new
    @project = Project.new
  end

  def create
    authorize @project
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
  end

  def update
    authorize @project
  end

  def destroy
    authorize @project
  end
end
