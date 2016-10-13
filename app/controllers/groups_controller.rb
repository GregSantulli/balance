class GroupsController < ApplicationController

  before_action :authenticate_user!

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      current_user.groups << @group
      redirect_to group_path @group
    else
      render @group
    end
  end

  def show
    @group = Group.find(params[:id])
    @expense = Expense.new(date: Date.today)
    @expenses = @group.expenses.where(settled: [false, nil]).order(date: :desc)
    @total_outstanding = @expenses.sum(:amount)
    @split = @total_outstanding / @group.users.count
    @expense_hash = @group.user_balance_hash
  end

  def settle
    @group = Group.find(params[:group_id])
    @group.settle_outstanding_expenses
    redirect_to group_path @group
  end

  def add_user
    p params
  end


  private

  def group_params
     params.require(:group).permit(:name, :address)
  end

end
