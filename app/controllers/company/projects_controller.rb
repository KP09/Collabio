class Company::ProjectsController < Company::CompanyController
  def show
    @project = Project.find(params[:id])
  end
end
