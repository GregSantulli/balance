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
  end

  private

  def group_params
     params.require(:group).permit(:name, :address)
  end

end
