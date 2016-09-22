class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @group = current_user.groups.first
    if @group
      redirect_to group_path @group
    end
  end

end
