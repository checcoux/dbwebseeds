class PhotoalbumPolicy < ApplicationPolicy
  def index?
    user.admin? or user.section
  end

  def show?
    true
  end

  def download?
    show?
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