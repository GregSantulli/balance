class Group < ActiveRecord::Base

  has_many :expenses

  has_many :memberships
  has_many :users, through: :memberships

  def user_expense_hash
    expense_hash = Hash.new(0)

    group_expenses = Expense.where(group_id: self.id)
    group_expenses.each do |expense|

    end

  end



end
