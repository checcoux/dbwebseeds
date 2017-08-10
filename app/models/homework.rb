class Homework < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  has_many :grades, dependent: :destroy
end
