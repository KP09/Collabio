class Company::DashboardController < Company::CompanyController
  def index
  	@user = current_user
  	@project = Project.new
  	@active_projects = @user.active_projects
  	@closed_projects = @user.closed_projects
  end
end
