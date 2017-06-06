class ProjectPolicy < ApplicationPolicy

	def create?
	  user.company == true
  end

  def edit?
    record.user == user
  end

	def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  # No specific authorisation is needed to view contributinos other than being logged in
  class Scope < Scope
    def resolve	
      scope.where(record.user == user)
    end
  end
end
