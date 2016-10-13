class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :apartment, presence: true

  has_many :expenses
  has_many :memberships
  has_many :groups, through: :memberships

  def group_expenses(group)

  end

end
