class Company::ProjectsController < Company::CompanyController
  before_action :set_project
  def show
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end
end
