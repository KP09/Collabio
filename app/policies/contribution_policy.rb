class ContributionPolicy < ApplicationPolicy

	def create?
	  user.company == false
  end

  def edit?
    true
  end

	def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def star?
    record.project.user == user && user.is_company?
  end

  def unstar?
    record.project.user == user && user.is_company?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
