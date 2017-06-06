class ProjectsController < ApplicationController
  def show
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
