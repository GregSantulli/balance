class GroupsController < ApplicationController

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
    @expenses = @group.expenses.order(created_at: :desc)
    @total_outstanding = @expenses.sum(:amount)
    @split = @total_outstanding / @group.users.count
    @expense_hash = @group.user_balance_hash
  end

  private

  def group_params
     params.require(:group).permit(:name, :address)
  end

end
