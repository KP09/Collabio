class Company::DashboardController < Company::CompanyController
  def index
  	@user = current_user
  	@active_projects = @user.active_projects
  	@closed_projects = @user.closed_projects
  end
end
