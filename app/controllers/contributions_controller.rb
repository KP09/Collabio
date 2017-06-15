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
      redirect_to project_path(@project)
      flash[:alert] = "Oops! You've missed something"
  	end
  end

  def update
  	@contribution = Contribution.find(params[:id])
    authorize @contribution
  	@contribution.user = current_user
    @project = Project.find(params[:project_id])
  	if @contribution.save
  	  render 'projects/show'
  	else
  	  redirect_to project_path(@project)
      flash[:alert] = "Oops! You've missed something"
  	end
  end

  def destroy
  	@contribution = Contribution.find(params[:id])
    authorize @contribution
  	@project = @contribution.project
  	@contribution.delete
    redirect_to project_path(@project)
  end

  def star
    @contribution = Contribution.find(params[:id])
    authorize @contribution
    @contribution.toggle_star
  end

  def unstar
    @contribution = Contribution.find(params[:id])
    authorize @contribution
    @contribution.toggle_star
  end

  private

  def contribution_params
    params.require(:contribution).permit(:comment, :file)
  end

end

