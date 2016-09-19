class MembershipsController < ApplicationController

  def new
    @membership = Membership.new
  end

  def create


  end

  private

  def get_group
    @group = Group.find(params[:group_id])
  end

  def membership_params
     params.require(:membership).permit(:user_id, :group_id)
  end

end
