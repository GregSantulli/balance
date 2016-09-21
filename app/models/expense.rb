class Expense < ActiveRecord::Base

  belongs_to :user
  belongs_to :group

  def settle
    self.update_attributes(settled: true)
  end

end
