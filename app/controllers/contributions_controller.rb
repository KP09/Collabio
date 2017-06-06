class ContributionsController < ApplicationController
  def create
  	@project = Project.find(params[:project_id])
  	@contribution = Contribution.new
  	authorize @contribution
  	@contribution.project = @project
  	if @contribution.save
  	  redirect_to project_path(@contribution)
  	else
  	  render 'contributions/edit'
  	end
  end

  def update
  	@contribution = Contribution.find(params[:id])
  	@contribution.user = current_user
  	authorize @contribution
  	if @contribution.save
  	  redirect_to project_path(@contribution)
  	else
  	  render 'contributions/edit'
  	  # need to make sure the edit view of contributions is called 'edit!'
  	end
  end

  def destroy
  	@contribution = Contribution.find(params[:id])
  	@project = @contribution.project
  	authorize @contribution
  	@contribution.delete
    redirect_to project_path(@project)
  end
end
