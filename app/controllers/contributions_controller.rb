class ContributionsController < ApplicationController
  def create
  	@project = Project.find(params[:project_id])
  	@contribution = Contribution.new(contribution_params)
  	authorize @contribution
  	@contribution.project = @project
  	if @contribution.save
  	  redirect_to project_path(@contribution)
  	else
      @similar_projects = Project.all.sample(3)
  	  render 'projects/show'
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

  private

  def contribution_params
    params.require(:contribution).permit(:comment, :file)
  end

end

