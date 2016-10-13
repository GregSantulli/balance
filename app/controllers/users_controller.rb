class UsersController < ApplicationController


  def index
    @group = current_user.groups.first if current_user
    if @group
      redirect_to group_path @group
    end
  end

end
