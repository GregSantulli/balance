class Group < ActiveRecord::Base

  has_many :expenses

  has_many :memberships
  has_many :users, through: :memberships



end
