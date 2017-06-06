class ProjectsController < ApplicationController
  def show
    @similar_projects = Project.all.sample(3)
    @project = Project.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
