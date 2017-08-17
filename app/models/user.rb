# utente

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :section

  has_many :assignments, dependent: :destroy
  has_many :homeworks, dependent: :destroy
  has_many :grades, dependent: :destroy

  has_many :entities, dependent: :nullify
  has_many :instances, dependent: :nullify

  self.per_page = 20
end
