class ColumnImagePolicy < ApplicationPolicy
  def index?
    user.admin? or user.section
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def new?
    index?
  end

  def edit?
    index?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end