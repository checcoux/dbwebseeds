class InstancePolicy < ApplicationPolicy
  def index?
    user.id
  end

  def show?
    user.admin? or (record.user_id == user.id  && record.entity.stato > 0)
  end

  def create?
    user.admin? or (user.id && record.entity.stato == 1)
  end

  def new?
    create?
  end

  def edit?
    create?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
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