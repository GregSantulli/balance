class ExpensesController < ApplicationController

  before_action :authenticate_user!
  before_action :get_group, only: [:new, :create, :destroy, :settle]
  # before_action :confirm_expense_ownership, only: [:destory]

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user
    @expense.group = @group
    if @expense.save
      current_user.expenses << @expense
      redirect_to group_path @group
    else
      render @group
    end
  end

  def show

  end


  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    redirect_to group_path @group
  end

  private

  def confirm_expense_ownership

  end

  def get_group
    @group = Group.find(params[:group_id])
  end

  def expense_params
     params.require(:expense).permit(:description, :amount)
  end

end
