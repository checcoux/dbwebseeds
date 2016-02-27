class Layout < ActiveRecord::Base
  has_many :pages

  before_destroy :ensure_not_referenced

  private
  def ensure_not_referenced
    if pages.empty?
      return true
    else
      errors.add(:base, 'Layout utilizzato da alcune pagine')
      return false
    end
  end
end
