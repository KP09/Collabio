class ContributionsController < ApplicationController
  def create
  	@questions = Question.all
    @project = Project.find(params[:project_id])
    @user = current_user
  	@contribution = Contribution.new(contribution_params)
  	@contribution.project_id = @project.id
    @contribution.user_id = @user.id
    authorize @contribution
  	if @contribution.save
  	  redirect_to project_path(@project)
  	else
      @question = Question.new
      @similar_projects = Project.all
  	  render 'projects/show'
  	end
  end

  def update
  	@contribution = Contribution.find(params[:id])
    authorize @contribution
  	@contribution.user = current_user
  	if @contribution.save
  	  render 'projects/show'
  	else
  	  render 'projects/show'
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

