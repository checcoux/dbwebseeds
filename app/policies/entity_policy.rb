class EntityPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? or (user.id && !record.riservata)
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

  def update?
    create?
  end

  def destroy?
    create?
  end

  def pubblica?
    edit?
  end

  def nascondi?
    edit?
  end

  def duplica?
    edit?
  end

  def row0
    edit?
  end

  def nuovo_contenuto_dinamico?
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