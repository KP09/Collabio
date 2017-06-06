class ParticipationsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @participation = Participation.new
    @participation.project = @project
    @participation.user = current_user
    authorize @participation
    if @participation.save
      redirect_to project_path(@participation.project_id)
    else
      render :new
    end
  end

  def destroy
  	@project = Project.find(params[:id])
    @current_user = current_user
  	@participation = Participation.where(user_id: @current_user.id, project_id: @project.id).first
    @participation.destroy
  	authorize @participation
  	redirect_to project_path(@project)
  end
end
