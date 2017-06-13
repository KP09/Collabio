class Account::DashboardController < Account::AccountController
  def index
    @user = current_user
    @question = Question.new
    @contribution = Contribution.new
  end
end
