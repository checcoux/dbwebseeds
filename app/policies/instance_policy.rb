class InstancePolicy < ApplicationPolicy
  def index?
    user.id
  end

  def show?
    user.admin? or (record.user_id == user.id)
  end

  def create?
    user.admin? or (user.id && !record.entity.riservata)
  end

  def new?
    create?
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
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