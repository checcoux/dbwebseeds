class Ckeditor::AttachmentFilePolicy
  attr_reader :user, :attachment

  def initialize(user, attachment)
    @user = user

    if !user
      @user = User.new
    end

    @attachment = attachment
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