class Account::DashboardController < Account::AccountController
  def index
    @user = current_user
    @participations = Participation.where(user_id: current_user)
    @projects = Project.where(user_id: current_user)
    @contributions = Contribution.where(user_id: current_user)
    @upvotes = Upvote.where(user_id: current_user)
  end
end
