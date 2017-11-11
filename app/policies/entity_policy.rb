class EntityPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def vetrina?
    true
  end

  def show?
    user.admin? or (user.id && record.stato > 0)
  end

  def create?
    user.admin?
  end

  def new?
    create?
  end

  def edit?
    create?
  end

  def edit_instances?
    user.admin? or (user.id && record.stato == 1)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      if user
        if user.admin?
          scope.all
        elsif user.section
          scope.where(section_id: user.section)
        end
      else
        scope.where(visibile: true)
      end
    end
  end
end