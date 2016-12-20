class Ckeditor::PicturePolicy
  attr_reader :user, :picture

  def initialize(user, picture)
    @user = user

    if !user
      @user = User.new
    end

    @picture = picture
  end

  def index?
    user.admin? or user.section
  end

  def create?
    index?
  end

  def destroy?
    index?
  end
end