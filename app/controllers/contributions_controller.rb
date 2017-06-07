class ContributionsController < ApplicationController
  def create
  	@project = Project.find(params[:project_id])
    @user = current_user
  	@contribution = Contribution.new(contribution_params)
  	@contribution.project = @project
    @contribution.user = @user
    authorize @contribution
  	if @contribution.save
  	  redirect_to project_path(@contribution)
  	else
      @similar_projects = Project.all.sample(3)
  	  render 'projects/show'
  	end
  end

  def update
  	@contribution = Contribution.find(params[:id])
    authorize @contribution
  	@contribution.user = current_user
  	if @contribution.save
  	  redirect_to project_path(@contribution)
  	else
  	  render 'projects/show'
  	  # need to make sure the edit view of contributions is called 'edit!'
  	end
  end

  def destroy
  	@contribution = Contribution.find(params[:id])
    authorize @contribution
  	@project = @contribution.project
  	@contribution.delete
    redirect_to project_path(@project)
  end

  private

  def contribution_params
    params.require(:contribution).permit(:comment, :file)
  end

end

