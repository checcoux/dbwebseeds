class PagePolicy < ApplicationPolicy
  def index?
    user.admin? or user.section
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(section_id: user.section)
      end
    end
  end
end