class UserPolicy < ApplicationPolicy

  def edit?
    true
  end

	def update?
    true
  end

  def destroy?
    record.user == user
  end

end
