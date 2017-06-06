class ParticipationsController < ApplicationController
  def create
    @project = project.find(params[:project_id])
    @participation = Participation.new
    @participation.project = @project
    @participation.user = current_user
    if @participation.save
      redirect_to project_path(@participation.project_id)
    else
      render :new
    end
  end

  def destroy
  end
end
