class TagPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def cloud?
    true
  end

  def cloud3d?
    true
  end

  def show?
    user.admin?
  end

  def create?
    user.admin?
  end

  def new?
    create?
  end

  def edit?
    user.admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

end