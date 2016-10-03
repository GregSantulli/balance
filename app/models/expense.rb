class Expense < ActiveRecord::Base

  belongs_to :user
  belongs_to :group

  validates :description, presence: true
  validates :amount, presence: true
  validates :date, presence: true
  validates :user, presence: true
  validates :group, presence: true


  def settle
    self.update_attributes(settled: true)
  end

end
