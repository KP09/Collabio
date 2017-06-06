class ParticipationPolicy < ApplicationPolicy
  
	def create?
	  user.company == false
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
