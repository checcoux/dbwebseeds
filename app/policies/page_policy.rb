class PagePolicy < ApplicationPolicy
  def index?
    user.admin? or user.section
  end

  def show?
    user.admin? or user.section or record.visibile
  end

  def create?
    user.admin? or user.section
  end

  def new?
    create?
  end

  def edit?
    user.admin? or (record.section == user.section)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
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
      if user.admin?
        scope.all
      elsif user.section
        scope.where(section_id: user.section)
      else
        scope.where(visibile: true)
      end
    end
  end
end