class Group < ActiveRecord::Base

  has_many :expenses

  has_many :memberships
  has_many :users, through: :memberships

  def user_balance_hash
    expense_hash = {}
    even_split = even_split_amount
    self.users.each do |user|
      expense_hash[user.first_name] = even_split - outstanding_expenses_for(user)
    end
    expense_hash
  end

  def outstanding_expenses_for(user)
    self.expenses.where(user_id: user.id).sum(:amount)
  end

  def total_outstanding_expenses_amount
    self.expenses.sum(:amount)
  end

  def even_split_amount
    total_outstanding_expenses_amount.to_f / self.users.count
  end

end
